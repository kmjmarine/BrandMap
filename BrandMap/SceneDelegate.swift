//
//  SceneDelegate.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let rootViewController = TabbarController()
        //let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        
        self.window?.rootViewController = rootViewController
        self.window?.backgroundColor = .white
        self.window?.tintColor = .label
        self.window?.makeKeyAndVisible()
    }
}

