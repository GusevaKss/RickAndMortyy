//
//  PlayersListAssembly.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import Foundation

class PlayersListAssembly {
    private let networkService: PlayersNetworkProtocol
    private let storage: PlayersStorageWorkerProtocol
    
    init(networkService: PlayersNetworkProtocol, storage: PlayersStorageWorkerProtocol) {
        self.networkService = networkService
        self.storage = storage
    }
    
    func buildPlayers() -> PlayersListViewController {
        return PlayersListViewController(network: networkService, storage: storage)
    }
}

