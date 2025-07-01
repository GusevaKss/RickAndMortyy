//
//  PlayersListCell.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import UIKit
import SnapKit
import Kingfisher

class PlayersListCell: UITableViewCell {
    
    static let identifier = "PlayerCell"
    
    private let playerNumber: UILabel = {
        let number = UILabel()
        number.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        number.lineBreakMode = .byTruncatingTail
        number.numberOfLines = 1
        return number
    }()
    
    private let playerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        name.lineBreakMode = .byTruncatingTail
        name.numberOfLines = 1
        return name
    }()
    
    private let matchesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private let uspLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(playerNumber)
        contentView.addSubview(playerImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(matchesLabel)
        contentView.addSubview(uspLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        playerNumber.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
        }
        
        playerImage.snp.makeConstraints { make in
            make.left.equalTo(playerNumber.snp.right).offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        uspLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        matchesLabel.snp.makeConstraints { make in
            make.right.equalTo(uspLabel.snp.left).offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(playerImage.snp.right).offset(8)
            make.right.equalTo(matchesLabel.snp.left).offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with player: PlayersListItem) {
        
        playerNumber.text = "\(player.number)"
        playerImage.image = player.image
        nameLabel.text = player.name
        matchesLabel.text = player.matches
        uspLabel.text = player.usp
        
    }
}
