//
//  AlertFactory.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 22/05/21.
//

import Foundation
import UIKit

struct AlertFactory {
    private init() {}
    
    // MARK: - No internet alert
    static var defaultNoInternetAlert: UIAlertController = {
        let alertController = createAlertController(title: "Ooops...",
                                                    message: "Parece que seu dispositivo está sem internet. Por favor, verifique sua conexão e tente reiniciar o aplicativo.",
                                                    style: .alert)
        alertController.addAction(createAlertAction(title: "OK", style: .default, handler: nil))
        
        return alertController
    }()
    
    // MARK: - No origin and destiny selected alert
    static var noOriginAndDestinySelectedAlert: UIAlertController = {
        let alertController = createAlertController(title: "Ooops...",
                                                    message: "Acho que você esqueceu de selecionar a moeda de origem e/ou a de destino. Por favor, escolha as moedas de tente novamente.",
                                                    style: .alert)
        alertController.addAction(createAlertAction(title: "OK", style: .default, handler: nil))
        
        return alertController
    }()
    
    // MARK: - Not number valid aert
    static var notNumberValidAlert: UIAlertController = {
        let alertController = createAlertController(title: "Ooops...",
                                                    message: "Você preencheu corretamente o campo que indica o valor a ser convertido?",
                                                    style: .alert)
        alertController.addAction(createAlertAction(title: "OK", style: .default, handler: nil))
        
        return alertController
    }()
    
    // MARK: - Not number valid and no origin and destiny selected alert
    static var notNumberValidAndNoOriginAndDestinySelectedAlert: UIAlertController = {
        let alertController = createAlertController(title: "Ooops...",
                                                    message: "Por favor, preencha o valor para converter, depois selecione as moedas de origem e destino.",
                                                    style: .alert)
        alertController.addAction(createAlertAction(title: "OK", style: .default, handler: nil))
        
        return alertController
    }()
    
    // MARK: - Same origin and destiny alert
    static var sameOriginAndDestinyAlert: UIAlertController = {
        let alertController = createAlertController(title: "Ooops...",
                                                    message: "Por favor, certifique-se de que a origem e o destino selecionados são diferentes.",
                                                    style: .alert)
        alertController.addAction(createAlertAction(title: "OK", style: .default, handler: nil))
        
        return alertController
    }()
    
    
    // MARK: - Private factories
    private static func createAlertController(title: String, message: String, style: UIAlertController.Style) -> UIAlertController {
        
        return UIAlertController(title: title,
                                 message: message,
                                 preferredStyle: style)
    }
    
        
    private static func createAlertAction(title: String, style: UIAlertAction
                                            .Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: title,
                             style: style,
                             handler: handler)
    }
}
