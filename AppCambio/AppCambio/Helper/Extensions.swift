//
//  Extensions.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import UIKit

extension Double {

    func casasDecimais(_ qtd: Int) -> String {
        return String(format: "%.\(qtd)f", self)
    }
    
}

extension UIViewController {

    func startLoading(_ textInfo: String) {
        Thread.isMainThread ? createLoadingView(textInfo) : DispatchQueue.main.async { self.createLoadingView(textInfo) }
    }

    func createLoadingView(_ textInfo: String) {
        let loadView = LoadingView.instanceFromNib()
        loadView.updateInfo(textInfo)
        loadView.restorationIdentifier = "LoadingView"
        loadView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadView)
        view.bringSubviewToFront(loadView)
        loadView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func stopLoading() {
        Thread.isMainThread ? removeLoadingView() : DispatchQueue.main.async { self.removeLoadingView() }
    }

    func removeLoadingView() {
        for subView in view.subviews where subView.restorationIdentifier == "LoadingView" {
            subView.removeFromSuperview()
        }
    }
}
