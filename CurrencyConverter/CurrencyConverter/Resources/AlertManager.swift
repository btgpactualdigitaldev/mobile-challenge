//
//  AlertManager.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import UIKit

class AlertManager {
    
    /// Cria um alerta simples apenas com um título, a messagem e um botão de confirmação
    func createGenericAlert(title: String, message: String, buttonTitle: String = "Ok", completionButtonClicked: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: completionButtonClicked))
        return alertController
    }
}
