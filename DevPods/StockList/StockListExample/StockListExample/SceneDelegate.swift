//
//  SceneDelegate.swift
//  StockListExample
//
//  Created by Artyom Kudryashov on 29.02.2020.
//  Copyright © 2020 disrupt. All rights reserved.
//

import UIKit
import StockList

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: scene)
            self.window = window
            let controller = StockListViewController(presenter: .init())
            let rootViewController = UINavigationController(rootViewController: controller)
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
