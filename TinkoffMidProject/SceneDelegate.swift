//
//  SceneDelegate.swift
//  TinkoffMidProject
//
//  Created by Georgy Fesenko on 19/02/2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: scene)
            self.window = window
            let viewController = ViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
