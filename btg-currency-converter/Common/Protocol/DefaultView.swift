//
//  DefaultView.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 19/11/20.
//
import UIKit

protocol DefaultView {
    func buildView()
    func setupConstraints()
    func setupAditionalConfigurations()
    func setupView()
}

extension DefaultView{
    func setupView(){
        buildView()
        setupConstraints()
        setupAditionalConfigurations()
    }
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
}

