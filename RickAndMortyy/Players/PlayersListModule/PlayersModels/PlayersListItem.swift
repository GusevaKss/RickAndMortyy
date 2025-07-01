//
//  PlayersListItem.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import UIKit

struct PlayersListItem: Codable {
    let number: Int
    let imageData: Data?
    let name: String
    let matches: String
    let usp: String
    
    init(number: Int, image: UIImage?, name: String, matches: String, usp: String) {
        self.number = number
        self.imageData = image?.pngData()
        self.name = name
        self.matches = matches
        self.usp = usp
    }
    
    var image: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
}
