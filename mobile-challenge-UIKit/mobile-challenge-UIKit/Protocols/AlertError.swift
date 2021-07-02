//
//  AlertError.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 19/12/20.
//

import UIKit

protocol AlertError: UIViewController {

    /// Shows a custom error alert
    /// - Parameters:
    ///   - title: error title
    ///   - message: error message
    func showError(title: String, message: String)
}

extension AlertError {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LiteralText.ok, style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
