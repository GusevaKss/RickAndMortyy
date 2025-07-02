//
//  PlayersListViewController.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import UIKit
import SnapKit

class PlayersListViewController: UIViewController{
    private let network: PlayersNetworkProtocol
    private let storage: PlayersStorageWorkerProtocol

    private let searchController = UISearchController(searchResultsController: nil)
    
    private var players: [PlayersListItem] = []
    private var filteredPlayers: [PlayersListItem] = []
    
    private var isSearching: Bool {
        return !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(PlayersListCell.self, forCellReuseIdentifier: PlayersListCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.sectionHeaderTopPadding = 0.0
        table.keyboardDismissMode = .interactive
        return table
    }()
    
    init(network: PlayersNetworkProtocol, storage: PlayersStorageWorkerProtocol) {
        self.network = network
        self.storage = storage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        setupConstraints()

        loadPlayersFromUserDefaults()
        
        obtainPlayersIfNeed()
        
        setupSearchController()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
            navigationItem.rightBarButtonItem = addButton
        
        setupKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func didTapAddButton() {
        let bottomSheet = AddPlayerBottomSheetViewController()
            bottomSheet.onAddPlayer = { [weak self] newPlayer in
                self?.updatePlayersList(with: newPlayer)
            }
            
            if let sheet = bottomSheet.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }
            
            present(bottomSheet, animated: true)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func fetchPlayersList() {
        network.fetchPlayersList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let players):
                    self?.players = players
                    self?.tableView.reloadData()
                case .failure(let error):
                    let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ОК", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Поиск игроков"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func updatePlayersList(with newPlayer: PlayersListItem) {
        players.insert(newPlayer, at: 0)
        savePlayersToUserDefaults()
        tableView.reloadData()
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func savePlayersToUserDefaults() {
        storage.save(players: players)
    }

    private func loadPlayersFromUserDefaults() {
        players = storage.load()
    }
    
    private func obtainPlayersIfNeed() {
        guard players.isEmpty else {return}
        fetchPlayersList()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let tabBarHeight = tabBarController?.tabBar.bounds.height ?? 0
        let bottomInset = keyboardFrame.height - tabBarHeight
        tableView.contentInset.bottom = bottomInset
        tableView.verticalScrollIndicatorInsets.bottom = bottomInset
    }

    @objc private func keyboardWillHide(notification: Notification) {
        tableView.contentInset.bottom = 0
        tableView.verticalScrollIndicatorInsets.bottom = 0
    }
}

// MARK: - UITableViewDelegate

extension PlayersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let player = isSearching ? filteredPlayers[indexPath.row] : players[indexPath.row]
        let detailVC = PlayerDetailViewController(player: player)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return PlayersListHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (_, _, completionHandler) in
            guard let self = self else {
                completionHandler(false)
                return
            }

            let alert = UIAlertController(title: "Вы уверены?", message: "Хотите удалить игрока?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Нет", style: .cancel) { _ in
                completionHandler(false)
            })

            alert.addAction(UIAlertAction(title: "Да", style: .destructive) { _ in
                if self.isSearching {
                    let playerToDelete = self.filteredPlayers[indexPath.row]
                    self.filteredPlayers.remove(at: indexPath.row)
                    self.players.removeAll { $0.number == playerToDelete.number }
                } else {
                    self.players.remove(at: indexPath.row)
                }

                tableView.deleteRows(at: [indexPath], with: .automatic)
                completionHandler(true)
                self.savePlayersToUserDefaults()
            })
            self.present(alert, animated: true)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

// MARK: - UITableViewDataSource

extension PlayersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredPlayers.count : players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayersListCell.identifier, for: indexPath) as? PlayersListCell else {
            return UITableViewCell()
        }
        
        let player = isSearching ? filteredPlayers[indexPath.row] : players[indexPath.row]
        cell.configure(with: player)
        
        return cell
    }
}

// MARK: - UISearchResultsUpdating

extension PlayersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text?.lowercased() else { return }
        filteredPlayers = players.filter {
            $0.name.lowercased().contains(query) ||
            $0.usp.lowercased().contains(query) ||
            $0.matches.lowercased().contains(query)
        }
        tableView.reloadData()
    }
}
