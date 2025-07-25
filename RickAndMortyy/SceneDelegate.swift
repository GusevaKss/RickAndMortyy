//
//  SceneDelegate.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 3.04.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()
        
        let rickAndMortyNetworkService = CharactersNetworkService()
        let characterListAssemblyFirst = CharacterListAssembly(networkService: rickAndMortyNetworkService)
        let characterListViewControllerFirst = characterListAssemblyFirst.buildR()
        characterListViewControllerFirst.tabBarItem = UITabBarItem(
            title: "Rick and Morty",
            image: UIImage(systemName: "list.bullet.clipboard"),
            tag: 0
        )
        let navigationControllerFirst = UINavigationController(rootViewController: characterListViewControllerFirst)
        
        let adventureTimeNetworkService = CharactersNetworkServiceAdventureTime()
        let characterListAssemblySecond = CharacterListAssembly(networkService: adventureTimeNetworkService)
        let characterListViewControllerSecond = characterListAssemblySecond.buildA()
        characterListViewControllerSecond.tabBarItem = UITabBarItem(
            title: "Adventure Time",
            image: UIImage(systemName: "list.bullet.clipboard.fill"),
            tag: 1
        )
        let navigationControllerSecond = UINavigationController(rootViewController: characterListViewControllerSecond)
        
        let playersListNetworkService = PlayersNetworkService()
        let storageWorker = PlayersStorageWorker()
        let playersListAssembly = PlayersListAssembly(networkService: playersListNetworkService, storage: storageWorker)
        let playersListViewController = playersListAssembly.buildPlayers()
        playersListViewController.tabBarItem = UITabBarItem(
            title: "Players",
            image: UIImage(systemName: "figure.cooldown"),
            tag: 2)
        
        let navigationControllerThird = UINavigationController(rootViewController: playersListViewController)
        
        let layoutPracticeNetworkService = ReservationNetworkService()
        let layoutPracticeAssembly = LayoutPracticeAssembly(networkService: layoutPracticeNetworkService)
        let layoutPracticeViewController = layoutPracticeAssembly.buildLayoutPractice()
        layoutPracticeViewController.tabBarItem = UITabBarItem(
            title: "Reservation",
            image: UIImage(systemName: "sun.min"),
            tag: 3)
        
        let navigationControllerFourth = UINavigationController(rootViewController: layoutPracticeViewController)
        
        tabBarController.viewControllers = [navigationControllerFirst, navigationControllerSecond, navigationControllerThird, navigationControllerFourth]
        
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}
