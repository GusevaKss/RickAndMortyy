//
//  ReservationNetworkProtocol.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 12.07.25.
//

import Foundation

protocol ReservationNetworkProtocol {
    func fetchReservationList(completion: @escaping (Result<[ReservationListItem], Error>) -> Void)
}
