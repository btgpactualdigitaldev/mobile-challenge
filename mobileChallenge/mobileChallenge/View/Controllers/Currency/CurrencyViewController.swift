//
//  ViewController.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 21/11/20.
//

import UIKit


/// Class Currency View Controller
class CurrencyViewController: UIViewController {

    //MARK: -Variables
    weak var coordinator: CoordinatorManager?
    let baseView = CurrencyView()
    let currencyModel = CurrencyDataVM()
    
    //MARK: -LoadView
    override func loadView() {
        self.view = baseView
    }
    
    //MARK: -viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //NavigationController Hidden
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargetButtons()
    }
}

//MARK: -Extensions
extension CurrencyViewController{
    @objc func firstButtonClicked(_ sender: Any){
        coordinator?.navigateToTableCurrencyVC(receiver: .currencyOrigin, delegateTableViewCurrency: self)
    }
    
    @objc func secondButtonClicked(_ sender: Any){
        coordinator?.navigateToTableCurrencyVC(receiver: .currencyDestiny, delegateTableViewCurrency: self)
    }
    
    
    @objc func convertButtonClicked(_ sender: Any){
        do{
            
            let string = baseView.receiverValue.text
            let number = Double(string ?? "0")
            
            let result = try currencyModel.convert(valueConvertion: number ?? 0.0, firstName: baseView.firstCurrencyButton.title(for: .normal)!, secondName: baseView.secondCurrencyButton.title(for: .normal)!)
            
            baseView.inputValue.text = "\(result)"
            
        }catch{
            if error as! ErrorViewModel == .zero{
               baseView.simpleAlert(viewController: self, "Alert!", "Invalid Value.", "OK")
            }
            baseView.simpleAlert(viewController: self, "Alert!", "Choose a Value.", "OK")
        }
    }
}

extension CurrencyViewController{
    func addTargetButtons(){
        baseView.firstCurrencyButton.addTarget(self, action: #selector(firstButtonClicked(_:)), for: .touchUpInside)
        baseView.secondCurrencyButton.addTarget(self, action: #selector(secondButtonClicked(_:)), for: .touchUpInside)
        baseView.convertButton.addTarget(self, action: #selector(convertButtonClicked(_:)), for: .touchUpInside)
    }
}

extension CurrencyViewController: PassDataDelegate{
    func passCurrencyAndNameData(name: String, quote: Double, to: CurrencyViewModelReceiver) {
        currencyModel.configureCurrencyName(name, baseView, to, quote)
    }
}
