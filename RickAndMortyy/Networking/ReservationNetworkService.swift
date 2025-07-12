//
//  ReservationNetworkService.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 12.07.25.
//

import Foundation

class ReservationNetworkService: ReservationNetworkProtocol {
    
    private let reservation = [
        ReservationListItem(office: "Кипр 1", place: "213", date: "12.01"),
        ReservationListItem(office: "Кипр 2", place: "108", date: "15.07"),
        ReservationListItem(office: "Кипр 3", place: "342", date: "22.09"),
        ReservationListItem(office: "Афины", place: "101", date: "05.08"),
        ReservationListItem(office: "Салоники", place: "67", date: "30.12"),
        ReservationListItem(office: "Пафос", place: "145", date: "11.11"),
        ReservationListItem(office: "Ларнака", place: "76", date: "01.01"),
        ReservationListItem(office: "Кипр 10", place: "573", date: "02.01"),
        ReservationListItem(office: "Кипр 12", place: "332", date: "25.08"),
        ReservationListItem(office: "Кипр 13", place: "435", date: "23.09")
    ]
    
    func fetchReservationList(completion: @escaping (Result<[ReservationListItem], Error>) -> Void) {
        completion(.success(reservation))
    }
}
