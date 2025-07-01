//
//  CharacterListAssembly.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import Foundation

class CharacterListAssembly {
    private let networkService: CharactersNetworkProtocol
    
    init(networkService: CharactersNetworkProtocol) {
        self.networkService = networkService
    }
    
    func buildA() -> CharacterListViewController {
        let characterListViewController = CharacterListViewController(network: networkService, listType: CharacterListType.AdvTime)
        return characterListViewController
    }
    
    func buildR() -> CharacterListViewController {
        let characterListViewController = CharacterListViewController(network: networkService, listType: CharacterListType.RickMorty)
        return characterListViewController
    }
}
