//
//  CharacterDetailLabelCell.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 6.05.25.
//

import UIKit

class CharacterDetailLabelTableViewCell: UITableViewCell {
    private let characterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(characterLabel)
        setupConstraints()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String) {
        characterLabel.text = text
    }
    
    private func setupConstraints() {
        characterLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16.0)
            make.verticalEdges.equalToSuperview().inset(2.0)
        }
    }
}
