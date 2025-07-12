//
//  LayoutPracticeAssembly.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 11.07.25.
//

import Foundation

class LayoutPracticeAssembly {
    private let networkService: ReservationNetworkProtocol
    
    init(networkService: ReservationNetworkProtocol) {
        self.networkService = networkService
    }
    
    func buildLayoutPractice() -> LayoutPracticeViewController {
        return LayoutPracticeViewController(network: networkService)
    }
}
