//
//  ExchangeVC.swift
//  MobileChallenge
//
//  Created by Vitor Gomes on 07/09/21.
//

import UIKit

class ExchangeVC: UIViewController {
    
    private var contentView = UIView()
    private var exchangeTitle = UILabel()
    private var currencyButton = UIButton()
    private var currencyTitle = UILabel()
    private var transferCardView = UIView()
    private var receiveCardView = UIView()
    private var transferTextField = UITextField()
    private var totalLabel = UILabel()
    
    private var transferPicker = UIPickerView()
    private var receivePicker = UIPickerView()
    
    private var transferPickerTextfield = UITextField()
    private var receiveTextField = UITextField()
    
    private var exchangeButton = UIButton()
    
    var origin: String?
    var destination: String?
    
    var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getListData()
        viewModel.getLiveData()
        setupLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListVC" {
            let listvc = segue.destination as? ListVC
            listvc?.initials = viewModel.keys
            listvc?.fullnames = viewModel.values
        }
        
    }
    // MARK: - Functions
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            @unknown default:
                break
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func toListVC() {
        performSegue(withIdentifier: "toListVC", sender: nil)
    }
    
    @objc func transferDoneClick() {
        transferPickerTextfield.resignFirstResponder()
    }
    
    @objc func receiveDoneClick() {
        receiveTextField.resignFirstResponder()
    }
    
    @objc func calculateExchange() {
        
        if transferTextField.text?.isEmpty == false{
            let double = viewModel.exchange(value: Double(transferTextField.text ?? "") ?? 0, origin: self.origin, destination: self.destination)
            totalLabel.text = "\(self.destination ?? "") \(double)"
        } else {
            showAlert(message: "Digite um valor")
        }
    }
}

// MARK: - Textfield Functions
extension ExchangeVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - Picker Functions

extension ExchangeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == transferPicker {
            origin = viewModel.keys[row]
            transferPickerTextfield.text = viewModel.values[row]
        } else {
            destination = viewModel.keys[row]
            receiveTextField.text = viewModel.values[row]
        }
    }
}

extension ExchangeVC: ListViewModelDelegate {
    func didSuccess(bool: Bool?) {
        DispatchQueue.main.async {
            self.transferPicker.delegate = self
            self.transferPicker.dataSource = self
            self.receivePicker.delegate = self
            self.receivePicker.dataSource = self
        }
    }
}

// MARK: - Layout

extension ExchangeVC {
    func setupLayout() {
        //view de fundo
        self.view.backgroundColor = Colors.primary
        
        //view content
        view.addSubview(contentView)
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
        
        //titulo
        view.addSubview(exchangeTitle)
        exchangeTitle.translatesAutoresizingMaskIntoConstraints = false
        exchangeTitle.text = "BTGExchange"
        exchangeTitle.textColor = .white
        NSLayoutConstraint.activate([
            exchangeTitle.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            exchangeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
        
        //botão de acesso a lista
        contentView.addSubview(currencyButton)
        currencyButton.translatesAutoresizingMaskIntoConstraints = false
        currencyButton.setTitle("Currency List", for: .normal)
        currencyButton.backgroundColor = Colors.primary
        currencyButton.tintColor = .white
        currencyButton.addTarget(self, action: #selector(toListVC), for: .touchUpInside)
        currencyButton.layer.cornerRadius = 8
        currencyButton.clipsToBounds = true
        NSLayoutConstraint.activate([
            currencyButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            currencyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            currencyButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05),
            currencyButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4)
        ])
        
        //texto faça seu cambio
        contentView.addSubview(currencyTitle)
        currencyTitle.translatesAutoresizingMaskIntoConstraints = false
        currencyTitle.numberOfLines = 0
        currencyTitle.text = "Make your Exchange:"
        currencyTitle.font = UIFont(name: "Arial", size: 20)
        currencyTitle.textColor = Colors.primary
        NSLayoutConstraint.activate([
            currencyTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            currencyTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            currencyTitle.trailingAnchor.constraint(equalTo: currencyButton.leadingAnchor, constant: -8),
            currencyTitle.centerYAnchor.constraint(equalTo: currencyButton.centerYAnchor)
        ])
        
        //view input do usuário
        contentView.addSubview(transferCardView)
        transferCardView.translatesAutoresizingMaskIntoConstraints = false
        transferCardView.backgroundColor = .white
        transferCardView.layer.shadowOpacity = 0.5
        transferCardView.layer.shadowOffset = .zero
        transferCardView.layer.shadowRadius = 2
        transferCardView.layer.cornerRadius = 8
        transferCardView.layer.shadowColor = UIColor.black.cgColor
        NSLayoutConstraint.activate([
            transferCardView.topAnchor.constraint(equalTo: currencyTitle.bottomAnchor, constant: 48),
            transferCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            transferCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
            transferCardView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2)
        ])
        
        let transferTitle = UILabel()
        transferCardView.addSubview(transferTitle)
        transferTitle.translatesAutoresizingMaskIntoConstraints = false
        transferTitle.text = "You Transfer:"
        transferTitle.textColor = Colors.defaultColor
        NSLayoutConstraint.activate([
            transferTitle.topAnchor.constraint(equalTo: transferCardView.topAnchor, constant: 8),
            transferTitle.centerXAnchor.constraint(equalTo: transferCardView.centerXAnchor)
        ])
        
        let transferImageView = UIImageView()
        transferCardView.addSubview(transferImageView)
        transferImageView.image = UIImage(named: "outline_payments_black_24pt")
        transferImageView.tintColor = .black
        transferImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            transferImageView.topAnchor.constraint(equalTo: transferTitle.bottomAnchor, constant: 16),
            transferImageView.leadingAnchor.constraint(equalTo: transferCardView.leadingAnchor, constant: 8),
            transferImageView.heightAnchor.constraint(equalToConstant: 24),
            transferImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        
        transferCardView.addSubview(transferTextField)
        transferTextField.translatesAutoresizingMaskIntoConstraints = false
        transferTextField.delegate = self
        transferTextField.addDoneCancelToolbar()
        transferTextField.keyboardType = .decimalPad
        transferTextField.layer.borderWidth = 0.5
        transferTextField.layer.borderColor = UIColor.black.cgColor
        transferTextField.textColor = Colors.defaultColor
        NSLayoutConstraint.activate([
            transferTextField.topAnchor.constraint(equalTo: transferImageView.topAnchor),
            transferTextField.leadingAnchor.constraint(equalTo: transferImageView.trailingAnchor, constant: 8),
            transferTextField.trailingAnchor.constraint(equalTo: transferCardView.trailingAnchor, constant: -32),
            transferTextField.bottomAnchor.constraint(equalTo: transferImageView.bottomAnchor)
        ])
        
        let pickerImageView = UIImageView()
        transferCardView.addSubview(pickerImageView)
        pickerImageView.image = UIImage(named: "outline_paid_black_24pt")
        pickerImageView.tintColor = .black
        pickerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerImageView.topAnchor.constraint(equalTo: transferImageView.bottomAnchor, constant: 16),
            pickerImageView.leadingAnchor.constraint(equalTo: transferCardView.leadingAnchor, constant: 8),
            pickerImageView.heightAnchor.constraint(equalToConstant: 24),
            pickerImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        let imagePicker = UIImageView()
        imagePicker.image = UIImage(named: "outline_keyboard_arrow_down_black_24pt")
        imagePicker.tintColor = .black
        
        //picker buttons
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(transferDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        transferPickerTextfield = UITextField()
        transferCardView.addSubview(transferPickerTextfield)
        transferPickerTextfield.leftViewMode = .always
        transferPickerTextfield.leftView = imagePicker
        transferPickerTextfield.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            transferPickerTextfield.topAnchor.constraint(equalTo: pickerImageView.topAnchor),
            transferPickerTextfield.leadingAnchor.constraint(equalTo: pickerImageView.trailingAnchor, constant: 8),
            transferPickerTextfield.trailingAnchor.constraint(equalTo: transferCardView.trailingAnchor, constant: -32),
            transferPickerTextfield.bottomAnchor.constraint(equalTo: pickerImageView.bottomAnchor)
        ])
        
        transferPicker = UIPickerView()
        transferPickerTextfield.inputView = transferPicker
        transferPickerTextfield.inputAccessoryView = toolBar
        
        
        //view input do usuário
        contentView.addSubview(receiveCardView)
        receiveCardView.translatesAutoresizingMaskIntoConstraints = false
        receiveCardView.backgroundColor = .white
        receiveCardView.layer.shadowOpacity = 0.5
        receiveCardView.layer.shadowOffset = .zero
        receiveCardView.layer.shadowRadius = 2
        receiveCardView.layer.cornerRadius = 8
        receiveCardView.layer.shadowColor = UIColor.black.cgColor
        NSLayoutConstraint.activate([
            receiveCardView.topAnchor.constraint(equalTo: transferCardView.bottomAnchor, constant: 36),
            receiveCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            receiveCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
            receiveCardView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2)
        ])
        
        let receiveTitle = UILabel()
        receiveCardView.addSubview(receiveTitle)
        receiveTitle.translatesAutoresizingMaskIntoConstraints = false
        receiveTitle.text = "You receive:"
        receiveTitle.textColor = Colors.defaultColor
        NSLayoutConstraint.activate([
            receiveTitle.topAnchor.constraint(equalTo: receiveCardView.topAnchor, constant: 8),
            receiveTitle.centerXAnchor.constraint(equalTo: receiveCardView.centerXAnchor)
        ])
        
        let receiveImageView = UIImageView()
        receiveCardView.addSubview(receiveImageView)
        receiveImageView.image = UIImage(named: "outline_paid_black_24pt")
        receiveImageView.tintColor = .black
        receiveImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            receiveImageView.topAnchor.constraint(equalTo: receiveTitle.bottomAnchor, constant: 16),
            receiveImageView.leadingAnchor.constraint(equalTo: receiveCardView.leadingAnchor, constant: 8),
            receiveImageView.heightAnchor.constraint(equalToConstant: 24),
            receiveImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        let imagePicker2 = UIImageView()
        imagePicker2.image = UIImage(named: "outline_keyboard_arrow_down_black_24pt")
        imagePicker2.tintColor = .black
        
        //picker buttons
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = .default
        toolBar2.isTranslucent = true
        toolBar2.sizeToFit()
        let doneButton2 = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(receiveDoneClick))
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar2.setItems([spaceButton2, doneButton2], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        receiveCardView.addSubview(receiveTextField)
        receiveTextField.leftViewMode = .always
        receiveTextField.leftView = imagePicker2
        receiveTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            receiveTextField.topAnchor.constraint(equalTo: receiveImageView.topAnchor),
            receiveTextField.leadingAnchor.constraint(equalTo: receiveImageView.trailingAnchor, constant: 8),
            receiveTextField.trailingAnchor.constraint(equalTo: receiveCardView.trailingAnchor, constant: -32),
            receiveTextField.bottomAnchor.constraint(equalTo: receiveImageView.bottomAnchor)
        ])
        
        receivePicker = UIPickerView()
        receiveTextField.inputView = receivePicker
        receiveTextField.inputAccessoryView = toolBar2
        
        let totalImageView = UIImageView()
        receiveCardView.addSubview(totalImageView)
        totalImageView.image = UIImage(named: "outline_price_check_black_24pt")
        totalImageView.tintColor = .black
        totalImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalImageView.topAnchor.constraint(equalTo: receiveImageView.bottomAnchor, constant: 16),
            totalImageView.leadingAnchor.constraint(equalTo: receiveCardView.leadingAnchor, constant: 8),
            totalImageView.heightAnchor.constraint(equalToConstant: 24),
            totalImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        receiveCardView.addSubview(totalLabel)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.textAlignment = .center
        totalLabel.font = UIFont(name: "Arial", size: 24)
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: receiveTextField.bottomAnchor, constant: 16),
            totalLabel.leadingAnchor.constraint(equalTo: totalImageView.trailingAnchor, constant: 8),
            totalLabel.trailingAnchor.constraint(equalTo: receiveCardView.trailingAnchor, constant: -32),
            
        ])
        
        
        contentView.addSubview(exchangeButton)
        exchangeButton.translatesAutoresizingMaskIntoConstraints = false
        exchangeButton.setTitleColor(.white, for: .normal)
        exchangeButton.setTitle("Calculate", for: .normal)
        exchangeButton.addTarget(self, action: #selector(calculateExchange), for: .touchUpInside)
        exchangeButton.layer.cornerRadius = 8
        exchangeButton.clipsToBounds = true
        exchangeButton.backgroundColor = Colors.primary
        NSLayoutConstraint.activate([
            exchangeButton.topAnchor.constraint(equalTo: receiveCardView.bottomAnchor, constant: 80),
            exchangeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            exchangeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            exchangeButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05)
        ])
        
        viewModel.delegate = self
        
    }
}
