////
////  DetailsViewController.swift
////  RickAndMortyy
////
////  Created by Kseniya Kovgorenya on 14.04.25.
////
//
//import UIKit
//
//class DetailsViewController: UIViewController {
//    
//    private let characterID: Int
//    private let network: PlayersNetworkProtocol
//    
//    private var model: DetailsViewModel?
//    
//    init(characterID: Int, network: PlayersNetworkProtocol) {
//        self.characterID = characterID
//        self.network = network
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        fetchData()
//    }
//    
//    private func fetchData() {
//        network.fetchPlayerData(id: characterID) { [weak self] result in
//            switch result {
//            case .success(let success):
//                self?.model = model
//            case .failure(let failure):
//                self?.model = nil
//            }
//        }
//    }
//}
