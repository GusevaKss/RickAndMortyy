//
//  CharacterDetailImageCell.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 6.05.25.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterDetailImageTableViewCell: UITableViewCell {
    struct ViewModel {
        let name: String
        let imageUrl: URL?
    }

    private let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private let characterName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(characterImage)
        contentView.addSubview(characterName)
        setupConstraints()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ViewModel) {
        if let url = viewModel.imageUrl {
            characterImage.kf.setImage(with: url)
        }
        characterName.text = viewModel.name
    }
    
    private func setupConstraints() {
        characterImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }

        characterName.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }
}
