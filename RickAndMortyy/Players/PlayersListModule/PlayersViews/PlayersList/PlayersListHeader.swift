//
//  PlayersListHeader.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import UIKit
import SnapKit

class PlayersListHeader: UIView {
    
    private let headerNumber: UILabel = {
        let number = UILabel()
        number.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        number.text = "№"
        return number
    }()
    
    private let headerPlayerImagePlaceholder: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let headerPlayer: UILabel = {
        let player = UILabel()
        player.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        player.text = "Игрок"
        return player
    }()
    
    private let headerMatches: UILabel = {
        let matches = UILabel()
        matches.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        matches.text = "Матчи"
        return matches
    }()
    
    private let headerUsp: UILabel = {
        let usp = UILabel()
        usp.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        usp.text = "УСП"
        return usp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(headerNumber)
        addSubview(headerPlayerImagePlaceholder)
        addSubview(headerPlayer)
        addSubview(headerMatches)
        addSubview(headerUsp)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        headerNumber.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        headerPlayerImagePlaceholder.snp.makeConstraints { make in
            make.left.equalTo(headerNumber.snp.left).offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        headerPlayer.snp.makeConstraints { make in
            make.left.equalTo(headerPlayerImagePlaceholder.snp.left).offset(65)
            make.centerY.equalToSuperview()
        }
        
        headerMatches.snp.makeConstraints { make in
            make.left.equalTo(headerUsp.snp.right).offset(-100)
            make.centerY.equalToSuperview()
        }
        
        headerUsp.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
        }
    }
}
