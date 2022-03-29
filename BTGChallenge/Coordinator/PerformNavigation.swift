//
//  PerformNavigation.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import UIKit

struct PeformNavigation {
    static func navigate(event: Destinys) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        guard let listCoordinators = sceneDelegate.appCoordinator?.childCoordinators else { return }
        sceneDelegate.appCoordinator?.callEvent(event: event)
        if !listCoordinators.isEmpty {
            listCoordinators.forEach({ coordinator in
                coordinator.callEvent(event: event)
            })
        }
    }
}
