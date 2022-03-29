//
//  HomeViewController.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 25/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()

    override func loadView() {
        super.loadView()
        let viewHome = HomeView(viewModel: self.viewModel)
        viewHome.delegate = self
        self.view = viewHome
    }

}

extension HomeViewController: HomeDelegate {
    func buttonClicked() {
        PeformNavigation.navigate(event: AppCoordinatorDestinys.conversion)
    }
}
