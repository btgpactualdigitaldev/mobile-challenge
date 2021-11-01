//
//  HomeViewController.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var inputValueTxtField: UITextField!
    @IBOutlet weak var inputCodeTxtField: UITextField!
    @IBOutlet weak var outputCodeTxtField: UITextField!
    @IBOutlet weak var outputValueLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var warningView: UIView!
    
    //MARK: - ViewModel attribute
    private var viewModel: HomeViewModel!
    
    //MARK: - Combine attributes
    private var cancellables = Set<AnyCancellable>()
    private let inputValueSubject = PassthroughSubject<String, Never>()
    private let inputCodeSubject = PassthroughSubject<String, Never>()
    private let outputCodeSubject = PassthroughSubject<String, Never>()
    
    var inputValuePublisher: AnyPublisher<String, Never> {
        inputValueSubject.eraseToAnyPublisher()
    }
    var inputCodePublisher: AnyPublisher<String, Never> {
        inputCodeSubject.eraseToAnyPublisher()
    }
    var outputCodePublisher: AnyPublisher<String, Never> {
        outputCodeSubject.eraseToAnyPublisher()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = Container.shared.resolve(HomeViewModel.self)
        binding()
        
        inputValueTxtField.delegate = self
        inputCodeTxtField.delegate = self
        outputCodeTxtField.delegate = self
        
        [inputValueTxtField, inputCodeTxtField, outputCodeTxtField].forEach { textField in
            textField?.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        
        convertButton.isEnabled = false
        warningView.isHidden = true
        warningView.layer.cornerRadius = 20
        
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputCodeTxtField.becomeFirstResponder()
    }
    
    //MARK: - Action methods
    @IBAction func touchConvert(_ sender: UIButton) {
        viewModel.convert()
    }
}

//MARK: - Binding methods
extension HomeViewController {
    private func binding() {
        cancellables = [
            viewModel.connectivityPublisher
                .receive(on: DispatchQueue.main)
                .debounce(for: .seconds(1), scheduler: DispatchQueue(label: "HomeViewController"))
                .sink(receiveValue: { [weak self] isConnected in
                    if !isConnected {
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self?.warningView.alpha = 0
                                self?.warningView.isHidden = false
                                self?.warningView.alpha = 1
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self?.warningView.alpha = 0
                                self?.warningView.isHidden = true
                                self?.warningView.alpha = 1
                            }
                        }
                    }
                }),
            viewModel.convertPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] result in
                    switch result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self?.outputValueLabel.alpha = 0
                                self?.outputValueLabel.text = value
                                self?.outputValueLabel.alpha = 1
                            }
                        }
                    case .failure(let error):
                        let exceptionVC = ExceptionViewController.instantiated()
                        exceptionVC.error = error
                        self?.navigationController?.pushViewController(exceptionVC, animated: true)
                    }
                }),
            inputValuePublisher
                .combineLatest(inputCodePublisher, outputCodePublisher)
                .sink { [weak self] inputValue, inputCode, outputCode  in
                    self?.convertButton.isEnabled = !inputValue.isEmpty && !inputCode.isEmpty && !outputCode.isEmpty
                }
        ]
        viewModel.attachInputValueListener(inputValuePublisher)
        viewModel.attachInputCodeListener(inputCodePublisher)
        viewModel.attachOutputCodeListener(outputCodePublisher)
    }
}

//MARK: - UITextField methods
extension HomeViewController: UITextFieldDelegate {
    @objc private func dismissKeyboard(_ gesture: UIGestureRecognizer) {
        inputValueTxtField.resignFirstResponder()
        inputCodeTxtField.resignFirstResponder()
        outputCodeTxtField.resignFirstResponder()
    }
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        if textField == inputValueTxtField {
            if let code = inputCodeTxtField.text, let valueString = textField.text?.toCurrency(withCode: code) {
                textField.text = valueString
            }
        } else if textField == inputCodeTxtField, let count = inputCodeTxtField.text?.count, count >= 3 {
            inputValueTxtField.becomeFirstResponder()
        } else if textField == outputCodeTxtField, let count = outputCodeTxtField.text?.count, count >= 3 {
            outputCodeTxtField.resignFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case inputValueTxtField:
            if let value = inputValueTxtField.text {
                inputValueSubject.send(value)
            }
        case inputCodeTxtField:
            if let code = inputCodeTxtField.text {
                inputCodeSubject.send(code)
            }
        case outputCodeTxtField:
            if let code = outputCodeTxtField.text {
                outputCodeSubject.send(code)
            }
        default:
            break
        }
    }
}
