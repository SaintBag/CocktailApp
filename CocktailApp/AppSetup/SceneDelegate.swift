//
//  SceneDelegate.swift
//  CocktailApp
//
//  Created by Sebulla on 14/05/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let winScene = (scene as? UIWindowScene) else { return }
            setupNavigationBarColors()
            let vc = CocktailSearchVC()
            let nc = UINavigationController(rootViewController: vc)

            let win = UIWindow(windowScene: winScene)
            win.rootViewController = nc
            win.makeKeyAndVisible()
            window = win
        }
        
        private func setupNavigationBarColors() {
            UINavigationBar.appearance().barTintColor = .systemPink
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        }
        
        func sceneDidDisconnect(_ scene: UIScene) {}
        func sceneDidBecomeActive(_ scene: UIScene) {}
        func sceneWillResignActive(_ scene: UIScene) {}
        func sceneWillEnterForeground(_ scene: UIScene) {}
        func sceneDidEnterBackground(_ scene: UIScene) {}
    }

