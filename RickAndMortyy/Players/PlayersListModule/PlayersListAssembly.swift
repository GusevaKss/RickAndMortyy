//
//  PlayersListAssembly.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import Foundation

class PlayersListAssembly {
    private let networkService: PlayersNetworkProtocol
    
    init(networkService: PlayersNetworkProtocol) {
        self.networkService = networkService
    }
    
    func buildPlayers() -> PlayersListViewController {
        return PlayersListViewController(network: networkService)
    }
}

