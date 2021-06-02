//
//  MainViewController.swift
//  Conversor de moedas
//
//  Created by Matheus Duraes on 21/12/20.
//

import UIKit

class MainViewController: UIViewController, UINavigationBarDelegate {
    
    lazy var presenter = MainPresenter(with: self)
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var buttonFROM: UIButton!
    @IBOutlet weak var buttonTO: UIButton!
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    var currencyCode: String = ""
    var currencyDescription: String = ""
    var source: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView(){
        if (source == "FROM") {
            UserDefaults.standard.set(currencyCode, forKey: "FROM_CODE")
            UserDefaults.standard.set(currencyDescription, forKey: "FROM_DESCRIPTION")
            UserDefaults.standard.synchronize()
        } else if(source == "TO") {
            UserDefaults.standard.set(currencyCode, forKey: "TO_CODE")
            UserDefaults.standard.set(currencyDescription, forKey: "TO_DESCRIPTION")
            UserDefaults.standard.synchronize()
        }
        
        let from_code = UserDefaults.standard.string(forKey: "FROM_CODE") ?? ""
        let from_description = UserDefaults.standard.string(forKey: "FROM_DESCRIPTION") ?? ""
        
        let to_code = UserDefaults.standard.string(forKey: "TO_CODE") ?? ""
        let to_description = UserDefaults.standard.string(forKey: "TO_DESCRIPTION") ?? ""
        
        self.buttonFROM.setTitle(from_code + " - " + from_description, for: .normal)
        self.buttonTO.setTitle(to_code + " - " + to_description, for: .normal)
        
        if(from_code == "") {
            self.buttonFROM.setTitle("Moeda origem", for: .normal)
        }
        if (to_code == "") {
            self.buttonTO.setTitle("Moeda destino", for: .normal)
        }
    }
    
    @IBAction func resultValueButton(_ sender: Any) {
        let from_code = UserDefaults.standard.string(forKey: "FROM_CODE") ?? ""
        let from_description = UserDefaults.standard.string(forKey: "FROM_DESCRIPTION") ?? ""
        
        let to_code = UserDefaults.standard.string(forKey: "TO_CODE") ?? ""
        let to_description = UserDefaults.standard.string(forKey: "TO_DESCRIPTION") ?? ""
        
        if presenter.validConvert(from: from_code, to: to_code) {
            presenter.convertCurrency(fromCode: from_code, fromDescription: from_description, toCode: to_code, toDescription: to_description)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "VFROM") {
            let vc = segue.destination as? CurrencyListViewController
            vc?.source = "FROM"
        } else if(segue.identifier == "VTO"){
            let vc = segue.destination as? CurrencyListViewController
            vc?.source = "TO"
        }
    }
    
}

extension MainViewController: MainPresenterView {
    
    func showProgress() {
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func hideProgress() {
        indicator.stopAnimating()
    }
    
    func showMsgError(msg: String) {
        let alert = UIAlertController(title: "Aviso!", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setResultLabel(text: String) {
        self.resultTextLabel.text = text
    }
    
    func getValueString() -> String {
        return self.valueTextField.text ?? ""
    }
    
    func resetSource() {
        source = ""
    }
    
}
