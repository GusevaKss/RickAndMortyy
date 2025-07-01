//
//  PlayersNetworkService.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import Foundation
import UIKit

class PlayersNetworkService: PlayersNetworkProtocol {
    
    private let players = [
        PlayersListItem(number: 1, image: UIImage(systemName: "person.fill"), name: "Misty88", matches: "40-6", usp: "6.39"),
        PlayersListItem(number: 2, image: UIImage(systemName: "person.fill"), name: "Arthur36", matches: "33-9", usp: "5.53"),
        PlayersListItem(number: 3, image: UIImage(systemName: "person.fill"), name: "Jason71", matches: "28-9", usp: "7.05"),
        PlayersListItem(number: 4, image: UIImage(systemName: "person.fill"), name: "Sean87", matches: "22-15", usp: "5.59"),
        PlayersListItem(number: 5, image: UIImage(systemName: "person.fill"), name: "Darryl40", matches: "22-8", usp: "8.38"),
        PlayersListItem(number: 6, image: UIImage(systemName: "person.fill"), name: "Msanchez", matches: "17-15", usp: "7.71"),
        PlayersListItem(number: 7, image: UIImage(systemName: "person.fill"), name: "Coxmisty", matches: "39-6", usp: "8.48"),
        PlayersListItem(number: 8, image: UIImage(systemName: "person.fill"), name: "Rachelmitchell", matches: "31-15", usp: "6.14"),
        PlayersListItem(number: 9, image: UIImage(systemName: "person.fill"), name: "Daniellejames", matches: "38-12", usp: "7.24"),
        PlayersListItem(number: 10, image: UIImage(systemName: "person.fill"), name: "Lisamiller", matches: "16-5", usp: "7.94"),
        PlayersListItem(number: 11, image: UIImage(systemName: "person.fill"), name: "Samuelsandra", matches: "14-9", usp: "5.12"),
        PlayersListItem(number: 12, image: UIImage(systemName: "person.fill"), name: "Tommyboyd", matches: "12-6", usp: "5.27"),
        PlayersListItem(number: 13, image: UIImage(systemName: "person.fill"), name: "Kimberlygonzales", matches: "19-17", usp: "5.65"),
        PlayersListItem(number: 14, image: UIImage(systemName: "person.fill"), name: "Walkerashley", matches: "24-13", usp: "6.29"),
        PlayersListItem(number: 15, image: UIImage(systemName: "person.fill"), name: "Bryansherry", matches: "39-11", usp: "7.97"),
        PlayersListItem(number: 16, image: UIImage(systemName: "person.fill"), name: "Anthony18", matches: "13-12", usp: "4.72"),
        PlayersListItem(number: 17, image: UIImage(systemName: "person.fill"), name: "Nathan95", matches: "29-19", usp: "5.91"),
        PlayersListItem(number: 18, image: UIImage(systemName: "person.fill"), name: "Ianmills", matches: "25-14", usp: "6.87"),
        PlayersListItem(number: 19, image: UIImage(systemName: "person.fill"), name: "Wrightdavid", matches: "26-7", usp: "7.14"),
        PlayersListItem(number: 20, image: UIImage(systemName: "person.fill"), name: "Aaronrich", matches: "17-12", usp: "5.43"),
        PlayersListItem(number: 21, image: UIImage(systemName: "person.fill"), name: "Henrycampbell", matches: "33-15", usp: "6.69"),
        PlayersListItem(number: 22, image: UIImage(systemName: "person.fill"), name: "Eduardomorgan", matches: "12-10", usp: "4.97"),
        PlayersListItem(number: 23, image: UIImage(systemName: "person.fill"), name: "Millerthomas", matches: "30-17", usp: "5.98"),
        PlayersListItem(number: 24, image: UIImage(systemName: "person.fill"), name: "Markfloyd", matches: "38-14", usp: "7.21"),
        PlayersListItem(number: 25, image: UIImage(systemName: "person.fill"), name: "Javierwilliams", matches: "27-11", usp: "6.84"),
        PlayersListItem(number: 26, image: UIImage(systemName: "person.fill"), name: "Kellybrown", matches: "31-19", usp: "5.79"),
        PlayersListItem(number: 27, image: UIImage(systemName: "person.fill"), name: "Hernandezrachel", matches: "34-10", usp: "7.11"),
        PlayersListItem(number: 28, image: UIImage(systemName: "person.fill"), name: "Charlesmurphy", matches: "19-13", usp: "6.02"),
        PlayersListItem(number: 29, image: UIImage(systemName: "person.fill"), name: "Nicoleedwards", matches: "29-18", usp: "6.26"),
        PlayersListItem(number: 30, image: UIImage(systemName: "person.fill"), name: "Jamesjackson", matches: "16-6", usp: "6.33"),
        PlayersListItem(number: 31, image: UIImage(systemName: "person.fill"), name: "Jonescrystal", matches: "25-20", usp: "5.61"),
        PlayersListItem(number: 32, image: UIImage(systemName: "person.fill"), name: "Andreamorris", matches: "30-12", usp: "6.92"),
        PlayersListItem(number: 33, image: UIImage(systemName: "person.fill"), name: "Alexharris", matches: "18-11", usp: "6.19"),
        PlayersListItem(number: 34, image: UIImage(systemName: "person.fill"), name: "Kennethhall", matches: "37-10", usp: "7.76"),
        PlayersListItem(number: 35, image: UIImage(systemName: "person.fill"), name: "Wendyadams", matches: "13-5", usp: "6.48"),
        PlayersListItem(number: 36, image: UIImage(systemName: "person.fill"), name: "Douglasclark", matches: "32-14", usp: "6.91"),
        PlayersListItem(number: 37, image: UIImage(systemName: "person.fill"), name: "Raymondgreen", matches: "21-16", usp: "5.39"),
        PlayersListItem(number: 38, image: UIImage(systemName: "person.fill"), name: "Sarahroberts", matches: "39-12", usp: "7.64"),
        PlayersListItem(number: 39, image: UIImage(systemName: "person.fill"), name: "Patriciaward", matches: "20-8", usp: "6.18"),
        PlayersListItem(number: 40, image: UIImage(systemName: "person.fill"), name: "Gregorycooper", matches: "29-9", usp: "7.28"),
        PlayersListItem(number: 41, image: UIImage(systemName: "person.fill"), name: "Haroldtorres", matches: "17-15", usp: "5.51"),
        PlayersListItem(number: 42, image: UIImage(systemName: "person.fill"), name: "Tiffanybrooks", matches: "24-14", usp: "6.27"),
        PlayersListItem(number: 43, image: UIImage(systemName: "person.fill"), name: "Vincentlee", matches: "34-18", usp: "6.93"),
        PlayersListItem(number: 44, image: UIImage(systemName: "person.fill"), name: "Lindamartinez", matches: "26-15", usp: "6.16"),
        PlayersListItem(number: 45, image: UIImage(systemName: "person.fill"), name: "Dennisking", matches: "31-10", usp: "7.05"),
        PlayersListItem(number: 46, image: UIImage(systemName: "person.fill"), name: "Victorparker", matches: "28-19", usp: "5.88"),
        PlayersListItem(number: 47, image: UIImage(systemName: "person.fill"), name: "Ashleycook", matches: "35-17", usp: "7.35"),
        PlayersListItem(number: 48, image: UIImage(systemName: "person.fill"), name: "Jonathanbell", matches: "20-14", usp: "5.84"),
        PlayersListItem(number: 49, image: UIImage(systemName: "person.fill"), name: "Christopherscott", matches: "33-11", usp: "7.02"),
        PlayersListItem(number: 50, image: UIImage(systemName: "person.fill"), name: "Marystewart", matches: "18-13", usp: "6.01")
    ]


    
    func fetchPlayerDetail(by id: Int, completion: @escaping (Result<PlayersListItem, Error>) -> Void) {
        if let player = players.first(where: { $0.number == id }) {
            completion(.success(player))
        } else {
            completion(.failure(NSError(domain: "PlayerNotFound", code: 404, userInfo: nil)))
        }
    }
    
    func fetchPlayersList(completion: @escaping (Result<[PlayersListItem], Error>) -> Void) {
        completion(.success(players))
    }
}
