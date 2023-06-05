//
//  SceneDelegate.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/16/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FBSDKCoreKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        guard let _ = (scene as? UIWindowScene) else { return }
        
    }
    
    //MARK: Setting SceneDelegate
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
    
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
                return
            }

            if Auth.auth().canHandle(url) {
                // Xử lý URL liên quan đến Firebase Auth
                // ...
            } else {
                ApplicationDelegate.shared.application(
                    UIApplication.shared,
                    open: url,
                    sourceApplication: nil,
                    annotation: [UIApplication.OpenURLOptionsKey.annotation]
                )
            }
    }
}

