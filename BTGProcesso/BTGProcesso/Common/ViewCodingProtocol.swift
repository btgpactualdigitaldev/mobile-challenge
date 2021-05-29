//
//  ViewCodingProtocol.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 08/12/20.
//

import Foundation

public protocol ViewCodingProtocol {
    
    ///Métodos para configurar as subviews na view
    func buildViewHierarchy()
    
    ///Método para configurar as constraints nas subviews
    func setupConstraints()
    
    /// Método para fazer alguma configuração adicional na view
    func setupAdditionalConfiguration()
    
    /// Método que chama os métodos auxiliares para configurar a view
    func setupView()
}


extension ViewCodingProtocol {
    
    func setupView(){
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration(){}

}
