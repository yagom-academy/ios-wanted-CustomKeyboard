//
//  SceneDelegate.swift
//  CustomKeyboard
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        let networkRequester = NetworkRequester()
        let reviewAPIProvider = ReviewAPIProvider(networkRequester: networkRequester)
        let profileImageProvider = ProfileImageProvider(networkRequester: networkRequester)
        let rootViewController = ReviewListViewController.instantiate(
            with: reviewAPIProvider,
            profileImageProvider
        )
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
