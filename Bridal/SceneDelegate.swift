//
//  SceneDelegate.swift
//  Bridal
//
//  Created by Abeer Hasan on 25/06/2021.
//

import UIKit
import FBSDKCoreKit
import MOLH

class SceneDelegate: UIResponder, UIWindowSceneDelegate, MOLHResetable{ //, MOLHResetable {
    var window: UIWindow?

    func reset() {
           let stry = UIStoryboard(name: "Main", bundle: nil)
           window?.rootViewController = stry.instantiateInitialViewController()
       }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    
    // Swift // // SceneDelegate.swift import FBSDKCoreKit ...
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) { guard let url = URLContexts.first?.url else { return }; ApplicationDelegate.shared.application( UIApplication.shared, open: url, sourceApplication: nil, annotation: [UIApplication.OpenURLOptionsKey.annotation] ) }

        
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

