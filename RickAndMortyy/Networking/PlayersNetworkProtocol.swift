//
//  PlayersNetworkProtocol.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import Foundation

protocol PlayersNetworkProtocol {
    func fetchPlayersList(completion: @escaping (Result<[PlayersListItem], Error>) -> Void)
    func fetchPlayerDetail(by id: Int, completion: @escaping (Result<PlayersListItem, Error>) -> Void)
}
