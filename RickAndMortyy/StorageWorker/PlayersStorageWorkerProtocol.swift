//
//  PlayersStorageWorkerProtocol.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 2.07.25.
//

import Foundation

protocol PlayersStorageWorkerProtocol {
    func save(players: [PlayersListItem])
    func load() -> [PlayersListItem]
}
