//
//  CharacterListViewController.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import UIKit
enum CharacterListType {
    case RickMorty
    case AdvTime
}

class CharacterListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var characters = [CharacterListItem]()
    private let network: CharactersNetworkProtocol
    private let listType: CharacterListType
    
    private var isLoadingCharacterDetails = false
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 150
        return tableView
    }()
    
    
    init(network: CharactersNetworkProtocol, listType: CharacterListType) {
        self.network = network
        self.listType = listType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCharacterList()
    }
    
    private func setupUI() {
        navigationItem.title = "Characters"
        
        view.addSubview(tableView)
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    private func fetchCharacterList() {
        network.fetchCharacterList { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching characters: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.identifier, for: indexPath) as? CharacterListCell else {
            return UITableViewCell()
        }
        
        let character = characters[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard !isLoadingCharacterDetails else { return }
        
        isLoadingCharacterDetails = true
        
        let selectedCharacter = characters[indexPath.row]
        guard let characterID = selectedCharacter.id else {
            isLoadingCharacterDetails = false
            return
        }
        
        network.fetchCharacterDetails(id: characterID) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoadingCharacterDetails = false
                
                switch result {
                case .success(let characterDetail):
                    let assembly = CharacterDetailAssembly()
                    let detailViewController: CharacterDetailViewController
                    
                    switch self.listType {
                    case .RickMorty:
                        detailViewController = assembly.buildR(with: characterDetail)
                        detailViewController.hidesBottomBarWhenPushed = true
                    case .AdvTime:
                        detailViewController = assembly.buildA(with: characterDetail)
                        detailViewController.hidesBottomBarWhenPushed = false
                    }
                    
                    self.navigationController?.pushViewController(detailViewController, animated: true)
                    
                case .failure(let error):
                    print("Failed to load character details: \(error.localizedDescription)")
                }
            }
        }
    }
}
