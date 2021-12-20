//
//  UIViewController+Extension.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 07/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(_ error: ApiError) {
        DispatchQueue.main.async { [weak self] in
            guard let wSelf = self else { return }
            
            let alert = UIAlertController(title: "Ops!", message: error.code?.friendlyCode() ?? "Erro inesperado", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            if LoadingManager.shared.isPresenting {
                wSelf.dismissLoading {
                    wSelf.present(alert, animated: true, completion: nil)
                }
            } else {
                wSelf.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func showLoading(_ callback: @escaping () -> Void = {}) {
        self.present(LoadingManager.shared, animated: true, completion: {
            LoadingManager.shared.isPresenting = true
            callback()
        })
    }
    
    func dismissLoading(_ callback: @escaping () -> Void = {}) {
        if LoadingManager.shared.isPresenting {
            LoadingManager.shared.isPresenting = false
            LoadingManager.shared.dismiss {
                callback()
            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
