//
//  BaseViewController.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    private var kBack = "voltar"
    private var kOk = "ok"
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - Public functions
    
    func setupNavigation() {
        UINavigationBar.appearance().barTintColor = .blue
        let backbutton = UIButton(type: .custom)
        backbutton.setTitle(kBack, for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .highlighted)
        backbutton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        }
    
    @objc func backAction() -> Void {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: kOk, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}
