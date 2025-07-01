//
//  PlayerDetailViewController.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 27.05.25.
//

import UIKit
import SnapKit
import Kingfisher

class PlayerDetailViewController: UIViewController {
    private let player: PlayersListItem
    
    private let playerImage: UIImageView = {
        let playerImage = UIImageView()
        playerImage.clipsToBounds = true
        playerImage.contentMode = .scaleAspectFill
        return playerImage
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    private let infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.font = UIFont.systemFont(ofSize: 16)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .left
        return infoLabel
    }()
    
    init(player: PlayersListItem) {
        self.player = player
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Player Detail"
        setupViews()
        configure(with: player)
    }
    
    private func setupViews() {
        view.addSubview(playerImage)
        view.addSubview(nameLabel)
        view.addSubview(infoLabel)
        
        playerImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(playerImage.snp.bottom).offset(4)
            make.left.equalTo(playerImage.snp.left)
            make.right.equalToSuperview().offset(-16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.left.equalTo(playerImage.snp.left)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    private func configure(with player: PlayersListItem) {
        playerImage.image = player.image ?? UIImage(systemName: "person.crop.circle")
        nameLabel.text = player.name
        infoLabel.text = "Матчи: \(player.matches), УСП: \(player.usp)"
    }
}
