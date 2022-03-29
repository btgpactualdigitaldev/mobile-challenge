//
//  ConversionView.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 25/03/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol ConversionDelegate: AnyObject {
    func buttonConvertClicked(valueToConvert: String)
    func buttonChoiceCurrencyOneClicked()
    func buttonChoiceCurrencyTwoClicked()
}

class ConversionView: UIView {
    
    var viewModel: ConversionViewModel
    weak var delegate: ConversionDelegate?
    let disposeBag = DisposeBag()
    
    var stackViewConvertion: UIStackView
    var stackViewResult: UIStackView
    var inputValueConvertion: UITextField
    var inputValueResul: UITextField
    var originCurrencyButton: UIButton
    var destinyCurrencyButton: UIButton
    var convertionButton: UIButton

    init(viewModel: ConversionViewModel, frame: CGRect = .zero) {
        self.viewModel = viewModel
        self.stackViewConvertion = UIStackView()
        self.stackViewResult = UIStackView()
        self.inputValueConvertion = UITextField()
        self.inputValueResul = UITextField()
        self.originCurrencyButton = UIButton()
        self.destinyCurrencyButton = UIButton()
        self.convertionButton = UIButton()
        super.init(frame: frame)
        applyViewCode()
        setUpObservers()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressedDismiss() {
        inputValueConvertion.resignFirstResponder()
    }
    
    @objc func pressedConvert() {
        delegate?.buttonConvertClicked(valueToConvert: inputValueConvertion.text ?? String())
    }
    
    @objc func pressedChoiceOne() {
        delegate?.buttonChoiceCurrencyOneClicked()
    }
    
    @objc func pressedChoiceTwo() {
        delegate?.buttonChoiceCurrencyTwoClicked()
    }
}

extension ConversionView {
    
    private func setUpObservers() {
        observerResult()
    }
    
    private func observerResult() {
        viewModel.result.subscribe(onNext: { [weak self] result in
            self?.inputValueResul.text = result
        }).disposed(by: self.disposeBag)
    }
    
}

extension ConversionView: ViewCodable {
    
    func buildHierarchy() {
        stackViewConvertion.addArrangedSubview(inputValueConvertion)
        stackViewConvertion.addArrangedSubview(originCurrencyButton)
        stackViewResult.addArrangedSubview(inputValueResul)
        stackViewResult.addArrangedSubview(destinyCurrencyButton)
        addSubview(stackViewConvertion)
        addSubview(stackViewResult)
        addSubview(convertionButton)
    }
    
    func setupConstraints() {
        stackViewConvertion.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin).offset(20)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        stackViewResult.snp.makeConstraints { make in
            make.top.equalTo(stackViewConvertion.snp.bottom).offset(20)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        convertionButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-40)
            make.left.equalTo(self.snp.left).offset(40)
            make.right.equalTo(self.snp.right).offset(-40)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        stackViewConvertion.axis  = .horizontal
        stackViewConvertion.distribution  = .fillEqually
        stackViewConvertion.alignment = .center
        stackViewConvertion.spacing   = 20.0
        
        stackViewResult.axis  = .horizontal
        stackViewResult.distribution  = .fillEqually
        stackViewResult.alignment = .center
        stackViewResult.spacing   = 20.0
        
        let finishButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - 50, y: 0, width: 30, height: UIScreen.main.bounds.height * 0.05))
        finishButton.setTitle("OK", for: .normal)
        finishButton.addTarget(self, action: #selector(pressedDismiss), for: .touchUpInside)
        finishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        finishButton.setTitleColor(.systemBlue, for: .normal)
        
        let viewAcessory = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.05))
        viewAcessory.backgroundColor = .systemFill
        viewAcessory.addSubview(finishButton)
        
        inputValueConvertion.inputAccessoryView = viewAcessory
        inputValueConvertion.placeholder = viewModel.placeholderConvertion
        inputValueConvertion.font = UIFont.systemFont(ofSize: 15)
        inputValueConvertion.borderStyle = UITextField.BorderStyle.roundedRect
        inputValueConvertion.autocorrectionType = UITextAutocorrectionType.no
        inputValueConvertion.keyboardType = .numberPad
        inputValueConvertion.returnKeyType = UIReturnKeyType.done
        inputValueConvertion.clearButtonMode = UITextField.ViewMode.whileEditing
        inputValueConvertion.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        inputValueConvertion.delegate = self
        
        inputValueResul.attributedPlaceholder = NSAttributedString(
            string: viewModel.placeholderResult,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        inputValueResul.backgroundColor = .systemFill
        inputValueResul.isUserInteractionEnabled = false
        inputValueResul.font = UIFont.systemFont(ofSize: 15)
        inputValueResul.borderStyle = UITextField.BorderStyle.roundedRect
        inputValueResul.autocorrectionType = UITextAutocorrectionType.no
        inputValueResul.keyboardType = .numberPad
        inputValueResul.returnKeyType = UIReturnKeyType.done
        inputValueResul.clearButtonMode = UITextField.ViewMode.whileEditing
        inputValueResul.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        inputValueResul.delegate = self
        
        originCurrencyButton.backgroundColor = .systemGray
        originCurrencyButton.layer.cornerRadius = 10
        originCurrencyButton.setTitle(viewModel.escolhaUmTextButton, for: .normal)
        originCurrencyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        originCurrencyButton.setTitleColor(.white, for: .normal)
        originCurrencyButton.addTarget(self, action: #selector(pressedChoiceOne), for: .touchUpInside)
        
        destinyCurrencyButton.backgroundColor = .systemGray
        destinyCurrencyButton.layer.cornerRadius = 10
        destinyCurrencyButton.setTitle(viewModel.escolhaDoisTextButton, for: .normal)
        destinyCurrencyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        destinyCurrencyButton.setTitleColor(.white, for: .normal)
        destinyCurrencyButton.addTarget(self, action: #selector(pressedChoiceTwo), for: .touchUpInside)
        
        convertionButton.backgroundColor = .systemGray
        convertionButton.layer.cornerRadius = 10
        convertionButton.setTitle(viewModel.convertTextButton, for: .normal)
        convertionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        convertionButton.setTitleColor(.white, for: .normal)
        convertionButton.addTarget(self, action: #selector(pressedConvert), for: .touchUpInside)
    }
}

extension ConversionView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string:  String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = newString.currencyInputFormatting()
        return false
    }
}
