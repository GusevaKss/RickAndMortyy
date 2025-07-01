//
//  CharacterDetailViewController.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import UIKit
import SnapKit
import Kingfisher

enum CharacterDetailCellsConfiguration {
    case image(CharacterDetailModel)
    case info(title: String, value: String)
}

class CharacterDetailViewController: UIViewController {
    private let characterDetail: CharacterDetailModel
    
    private var configurations: [CharacterDetailCellsConfiguration] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(characterDetail: CharacterDetailModel) {
        self.characterDetail = characterDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        buildCells()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CharacterDetailImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        tableView.register(CharacterDetailLabelTableViewCell.self, forCellReuseIdentifier: "labelCell")
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 20))
        footer.backgroundColor = .clear
        tableView.tableFooterView = footer
    }
    
    private func buildCells() {
        let typeValue: String
        if let type = characterDetail.type, !type.isEmpty {
            typeValue = type
        } else {
            typeValue = "Unknown"
        }
        
        configurations = [
            .image(characterDetail),
            .info(title: "Status", value: characterDetail.status ?? "N/A"),
            .info(title: "Species", value: characterDetail.species ?? "N/A"),
            .info(title: "Type", value: typeValue),
            .info(title: "Gender", value: characterDetail.gender ?? "N/A"),
            .info(title: "Origin", value: characterDetail.origin?.name ?? "N/A"),
            .info(title: "Location", value: characterDetail.location?.name ?? "N/A"),
            .info(title: "Episodes", value: "\(characterDetail.episode?.count ?? 0) episodes"),
            .info(title: "Created", value: characterDetail.created ?? "N/A")
        ]
    }
    
    private func getViewModel(with detail: CharacterDetailModel) -> CharacterDetailImageTableViewCell.ViewModel {
        CharacterDetailImageTableViewCell.ViewModel(
            name: detail.name ?? "",
            imageUrl: URL(string: detail.image ?? "")
        )
    }
}

// MARK: - UITableViewDataSource

extension CharacterDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch configurations[indexPath.row] {
        case .image(let detail):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? CharacterDetailImageTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: getViewModel(with: detail))
            return cell
            
        case .info(let title, let value):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as? CharacterDetailLabelTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: "\(title): \(value)")
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension CharacterDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch configurations[indexPath.row] {
        case .image:
            return 250
        case .info:
            return UITableView.automaticDimension
        }
    }
}
