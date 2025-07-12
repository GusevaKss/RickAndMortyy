//
//  LayoutPracticeViewController.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 11.07.25.
//

import UIKit
import SnapKit

final class LayoutPracticeViewController: UIViewController {

    private let network: ReservationNetworkProtocol
    private var reservations: [ReservationListItem] = []

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ReservationCell.self, forCellReuseIdentifier: ReservationCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.sectionHeaderTopPadding = 0
        table.separatorStyle = .none
        return table
    }()

    init(network: ReservationNetworkProtocol) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Бронирования"
        
        view.backgroundColor = .systemGroupedBackground
        tableView.backgroundColor = .clear
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }

        fetchReservations()
    }

    private func fetchReservations() {
        network.fetchReservationList { [weak self] result in
            switch result {
            case .success(let list):
                self?.reservations = list
                self?.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ОК", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension LayoutPracticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReservationCell.identifier, for: indexPath) as? ReservationCell else {
            return UITableViewCell()
        }
        let item = reservations[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LayoutPracticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
