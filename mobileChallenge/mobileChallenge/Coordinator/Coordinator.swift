//
//  Coordinator.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 21/11/20.
//

import Foundation
import UIKit


/// Protocolo Coordinator
protocol Coordinator {
    
    //MARK: -Variables
    /// Variável de Navegação das Controllers
    var navigationController: UINavigationController {get set}
    
    //MARK: -Functions
    /// Função que dá Start ao Coordinator
    func start()
}
