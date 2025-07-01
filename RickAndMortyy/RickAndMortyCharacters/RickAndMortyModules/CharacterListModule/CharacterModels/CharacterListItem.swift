//
//  CharacterListItem.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import Foundation

struct CharacterListItem: Codable {
    let id: Int?
    let name: String?
    let image: String?
}

struct CharacterListResponse: Codable {
    let results: [CharacterListItem]
}
