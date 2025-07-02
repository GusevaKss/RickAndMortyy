//
//  PlayersStorageWorker.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 2.07.25.
//

import Foundation

class PlayersStorageWorker: PlayersStorageWorkerProtocol {
    private let userDefaultsKey = "savedPlayers"
    private let defaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }
    
    func save(players: [PlayersListItem]) {
        do {
            let data = try JSONEncoder().encode(players)
            defaults.set(data, forKey: userDefaultsKey)
        } catch {
            print("Ошибка при сохранении игроков: \(error)")
        }
    }
    
    func load() -> [PlayersListItem] {
        guard let data = defaults.data(forKey: userDefaultsKey) else { return [] }
        do {
            return try JSONDecoder().decode([PlayersListItem].self, from: data)
        } catch {
            print("Ошибка при загрузке игроков: \(error)")
            return []
        }
    }
}
