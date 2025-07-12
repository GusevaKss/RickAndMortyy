//
//  ReservationCell.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 11.07.25.
//

import UIKit
import SnapKit

class ReservationCell: UITableViewCell {
    
    static let identifier = "ReservationCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "building.columns")
        image.tintColor = .systemBlue
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let officeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "Подробнее"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .systemBlue
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(officeLabel)
        containerView.addSubview(moreLabel)
        containerView.addSubview(arrowImageView)
        containerView.addSubview(placeLabel)
        containerView.addSubview(dateLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.left.right.equalToSuperview().inset(16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(12)
            make.size.equalTo(18)
        }
        
        officeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(6)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.right.equalToSuperview().inset(12)
            make.size.equalTo(10)
        }
        
        moreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(arrowImageView.snp.left).offset(-4)
        }
        
        placeLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(placeLabel)
            make.right.equalToSuperview().inset(12)
        }
    }
    
    func configure(with item: ReservationListItem) {
        officeLabel.text = item.office
        placeLabel.text = "Место: \(item.place)"
        dateLabel.text = "Передано до \(item.date)"
    }
}
