//
//  CharactersNetworkProtocol.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import Foundation

protocol CharactersNetworkProtocol {
    func fetchCharacterList(completion: @escaping (Result<[CharacterListItem], Error>) -> Void)
    func fetchCharacterDetails(id: Int, completion: @escaping (Result<CharacterDetailModel, Error>) -> Void)
}
