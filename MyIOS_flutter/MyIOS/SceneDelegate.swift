//
//  SceneDelegate.swift
//  MyIOS
//
//  Created by wangkun42 on 2022/4/7.
//

import UIKit
import flutter_boost

typealias ResultCallback = (Dictionary<AnyHashable, Any>) -> Void

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var navigation: UINavigationController {
        get {
            return self.window!.rootViewController as! UINavigationController
        }
    }
    
    var resultTable = Dictionary<String, ResultCallback>()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FlutterBoost.instance().setup(UIApplication.shared, delegate: self) { _ in }

        self.window = UIWindow(windowScene: scene as! UIWindowScene)
        self.window!.makeKeyAndVisible()

        let main = ViewController()
        self.window!.rootViewController = UINavigationController(rootViewController: main)
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

// MARK: FlutterBoostDelegate

extension SceneDelegate: FlutterBoostDelegate {
    func pushNativeRoute(_ pageName: String!, arguments: [AnyHashable : Any]!) {
        var target: UIViewController!
        if pageName == "main" {
            target = UIViewController()
        }

        let isAnimated = arguments["isAnimated"] as? Bool ?? false
        if arguments["isPresent"] as? Bool ?? false {
            self.navigation.present(target, animated: isAnimated, completion: nil)
        } else {
            self.navigation.pushViewController(target, animated: isAnimated)
        }
    }
    
    func pushFlutterRoute(_ options: FlutterBoostRouteOptions!) {
        let boostContainer = FBFlutterViewContainer()!
        boostContainer.setName(options.pageName, uniqueId: options.uniqueId, params: options.arguments, opaque: options.opaque)

        self.resultTable[options.pageName] = options.onPageFinished

        self.navigation.isNavigationBarHidden = true
        let isAnimated = options.arguments["isAnimated"] as? Bool ?? false
        if options.arguments["isPresent"] as? Bool ?? false || !options.opaque {
            self.navigation.present(boostContainer, animated: isAnimated, completion: nil)
        } else {
            self.navigation.pushViewController(boostContainer, animated: isAnimated)
        }
    }
    
    func popRoute(_ options: FlutterBoostRouteOptions!) {
        let presented = self.navigation.presentedViewController
        if let boostContainer = presented as? FBFlutterViewContainer, boostContainer.uniqueId() == options.uniqueId {
            if boostContainer.modalPresentationStyle == .fullScreen {
                self.navigation.topViewController!.beginAppearanceTransition(true, animated: false)
                boostContainer.dismiss(animated: true) {
                    self.navigation.topViewController!.endAppearanceTransition()
                }
            } else {
                boostContainer.dismiss(animated: true, completion: nil)
            }
        } else {
            self.navigation.popViewController(animated: true)
        }

        if let callback = self.resultTable[options.pageName] {
            callback(options.arguments)
            self.resultTable[options.pageName] = nil
        }
    }
}
