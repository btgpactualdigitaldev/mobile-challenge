//
//  ViewController.swift
//  DesafioBTG
//
//  Created by Rodrigo Goncalves on 04/11/20.
//

import UIKit
import CoreData

class CurrencyQuoteViewController: BaseViewController {
    
    //MARK: Outlet`s
    @IBOutlet weak var btnCurrencyOrigin: UIButton!
    @IBOutlet weak var btnCurrencyTarget: UIButton!
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var lblQuoteValue: UILabel!
    
    //MARK: Variable`s
    var dsCurrencyDataModel : NSFetchedResultsController<CurrencyDataModel>!
    var dsRateDataModel : NSFetchedResultsController<RateDataModel>!
    var userDefault = UserDefaults.standard
    
    private var currencyViewMode: CurrencyViewModel!
    private var rateViewMode: RatesViewModel!
   
    //MARK: Override`s
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    
        txtValue.delegate = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        buildLocalDataBase()
        bindViewModel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewCtrl = segue.destination as! SupportedCurrenciesViewController
        viewCtrl.delegate = self
        viewCtrl.currencyType = (sender as! Constants.CurrencyType)
        
    }
    
    //MARK: Function`s
    func setCurrency(_ currencyInfo: CurrencyInfo)  {
        
        userDefault.setValue(currencyInfo.initial, forKey: currencyInfo.currencyType!.rawValue)
        
        if let origin = userDefault.string(forKey: Constants.CurrencyType.origin.rawValue) {
            
            btnCurrencyOrigin.setTitle(origin, for: .normal)
            
        }
        
        if let target = userDefault.string(forKey: Constants.CurrencyType.target.rawValue) {
            
            btnCurrencyTarget.setTitle(target, for: .normal)
            
        }
    
        if !txtValue.text!.isEmpty {
            showCurrencyQuote()
        }
        
    }
    
    private func buildLocalDataBase() {
        
        let orderBy = NSSortDescriptor(key: "initial", ascending: true)
        
        let fetchRequest: NSFetchRequest<CurrencyDataModel> = CurrencyDataModel.fetchRequest()
        fetchRequest.sortDescriptors = [orderBy]
        
        dsCurrencyDataModel = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        dsCurrencyDataModel.delegate = self
        
        do {
            try dsCurrencyDataModel.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func bindViewModel() {
        
        
        self.currencyViewMode = CurrencyViewModel()
        self.currencyViewMode.bindViewModel = {
            self.loadSupportedCurrencies()
        }
    }
    
    func loadSupportedCurrencies() {
        
        let count = dsCurrencyDataModel.fetchedObjects?.count ?? 0
        
        if count == 0 {
            
            self.showLoading(onView: self.view, show: true)
            
            let result = self.currencyViewMode.data
            
            DispatchQueue.main.async {
            
                for item in result!.currencies {
                    
                    let currencyDataModel = CurrencyDataModel(context: self.context)
                    
                    currencyDataModel.fullname = item.fullName
                    currencyDataModel.initial = item.initial
                    
                    do {
                        try self.context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                self.showLoading(onView: self.view, show: false)
            }
        }
    
    }
    
    
    private func setLayout() {
        
        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [doneButton]
        toolBar.isUserInteractionEnabled = true
        txtValue.inputAccessoryView = toolBar
        
    }
    
    private func showCurrencyQuote() {
        
        if txtValue.text!.isEmpty || Float(txtValue.text!) == 0 {
            showAlert("Enter the amount to be converted.")
            return
        }
        
        self.showLoading(onView: self.view, show: true)
        
        self.rateViewMode = RatesViewModel()
        self.rateViewMode.bindViewModel = {
            
            let result = self.rateViewMode.data
         
            
            DispatchQueue.main.async {
            
                let orignCurrency = self.btnCurrencyOrigin.currentTitle
                let targetCurrency = self.btnCurrencyTarget.currentTitle
                
                let value = Float(self.txtValue.text!)
                var newValue: Float!
                
                if  orignCurrency != "USD" && targetCurrency == "USD" {
                    
                    let rateCode = "USD\(orignCurrency!)"
                   
                    let rateLiveValue = result?.filter({ $0.codeRate == rateCode }).first?.value
                    
                    newValue = value! / rateLiveValue!
                    
                } else if orignCurrency == "USD" {
                    
                    let rateCode = "USD\(targetCurrency!)"
                    let rateLiveValue = result?.filter({ $0.codeRate == rateCode }).first?.value
                    
                    newValue = value! * rateLiveValue!
                
                } else {
                    
                    let rateCodeUSD = "USD\(orignCurrency!)"
                    let rateLiveValueUSD = result?.filter({ $0.codeRate == rateCodeUSD }).first?.value
                    
                    let valueUSD = value! / rateLiveValueUSD!
                    
                    
                    let rateCode = "USD\(targetCurrency!)"
                    let rateLiveValue = result?.filter({ $0.codeRate == rateCode }).first?.value
                    
                    newValue = valueUSD * rateLiveValue!
                    
                }
                
                self.lblQuoteValue.text = String(format: "%.2f", newValue)
                self.lblQuoteValue.isHidden = false
                self.showLoading(onView: self.view, show: false)
            }
            
        }
        
    }
    
    @objc func doneButtonTapped() {
        txtValue.resignFirstResponder()
        showCurrencyQuote()
    }
    
    private func showAlert(_ msg: String) {
        
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        let alert = UIAlertController(title: "Warning", message: msg, preferredStyle: .alert)
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: Action`s
    @IBAction func changeCurrencyRate(_ sender: UIButton) {
        
        guard let titleOriginAux = btnCurrencyOrigin.titleLabel?.text else {
            return
        }
        
        guard let titleTargetAux = btnCurrencyTarget.titleLabel?.text else {
            return
        }
        
        btnCurrencyOrigin.setTitle(titleTargetAux, for: .normal)
        btnCurrencyTarget.setTitle(titleOriginAux, for: .normal)
        
        self.showCurrencyQuote()
    }
    
    @IBAction func changeCurrency(_ sender: UIButton) {
        
        let currencyType = sender.restorationIdentifier == "btnOrigin"  ? Constants.CurrencyType.origin : .target
        
        performSegue(withIdentifier: "segueSupportedCurrencies", sender: currencyType)
        
    }

}

extension CurrencyQuoteViewController: SelectedCurrencyDelegate {
    
    func setSelectedCurrency(_ currency: CurrencyInfo) {
        self.setCurrency(currency)
        
    }
    
}

extension CurrencyQuoteViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
    }
    
}

extension CurrencyQuoteViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        
        if string.count == 0 {
            return true
        }
        
        let userEnteredString = textField.text ?? ""
        
        var newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as NSString
        newString = newString.replacingOccurrences(of: ".", with: "") as NSString
        
        let centAmount : NSInteger = newString.integerValue
        let amount = (Double(centAmount) / 100.0)
        
        if newString.length < 16 {
            let str = String(format: "%0.2f", arguments: [amount])
            txtValue.text = str
        }
        
        return false
    }
    
}
