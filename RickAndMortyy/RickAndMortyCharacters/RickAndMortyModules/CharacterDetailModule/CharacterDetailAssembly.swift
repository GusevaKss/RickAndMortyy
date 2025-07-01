//
//  CharacterDetailAssembly.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import Foundation

class CharacterDetailAssembly {
    func buildR(with characterDetail: CharacterDetailModel) -> CharacterDetailViewController {
        let characterDetailViewController = CharacterDetailViewController(characterDetail: characterDetail)
        return characterDetailViewController
    }
    
    func buildA(with characterDetail: CharacterDetailModel) -> CharacterDetailViewController {
        let characterDetailViewController = CharacterDetailViewController(characterDetail: characterDetail)
        return characterDetailViewController
    }
}
