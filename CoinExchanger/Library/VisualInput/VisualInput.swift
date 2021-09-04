//
//  VisualInput.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 16/06/21.
//

import UIKit

protocol VisualInputDelegate: class {
    func didBeginEditing(_ input: VisualInput)
    func didChange(_ input: VisualInput)
    func didEndEditing(_ input: VisualInput, _ valid: Bool)
    func didReturn(_ input: VisualInput)
}

class VisualInput: UITextField {
    weak var visualDelegate: VisualInputDelegate?
    var inputEnabled = true
    var kind: ValidateType = .none
    var padding = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    
    var disabledColor: UIColor = UIColor.gray
    var errorColor: UIColor = UIColor.red
    var hightlighColor: UIColor = UIColor.blue
    
    var tempColor: UIColor = UIColor.black

    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        return view
    }()

    var errorLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = ""
        label.textColor = .red
        return label
    }()
    
    convenience init(kind: ValidateType) {
        self.init()
        self.kind = kind
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

private extension VisualInput {
    func setup() {
        backgroundColor = .clear
        font = UIFont.systemFont(ofSize: 16)
        textColor = .black
        
        delegate = self
        
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: backgroundView.bottomAnchor,
                                        constant: 4).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor,
                                         constant: 12).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: backgroundView.rightAnchor,
                                          constant: -12).isActive = true
        
        self.addTarget(self,
                       action: #selector(textFieldDidChange),
                       for: .editingChanged)
    }
    
    @objc
    func textFieldDidChange() {
        switch self.kind {
        case .cardCvv:
            self.text = Format.cardCVV(self.text ?? "")
        case .cardNumber:
            self.text = Format.cardNumber(self.text ?? "")
        case .cardVal:
            self.text = Format.cardVal(self.text ?? "")
        case .cep:
            self.text = Format.cep(self.text ?? "")
        case .cnpj:
            self.text = Format.cnpj(self.text ?? "")
        case .cpf:
            self.text = Format.cpf(self.text ?? "")
        case .cpfj:
            let t = Sanityze.number(self.text ?? "")
            self.text = t.count > 11
                ? Format.cnpj(t)
                : Format.cpf(t)
        case .date:
            self.text = Format.date(self.text ?? "")
        case .number:
            self.text = Sanityze.number(self.text ?? "")
        case .phone:
            self.text = Format.phone(self.text ?? "")
        case .time:
            self.text = Format.time(self.text ?? "")
        case .value:
            //self.text = Format.value(self.text ?? "")
            break
        default:
            break
        }
        
        visualDelegate?.didChange(self)
    }
    
}
extension VisualInput: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: Constants.animationDelay, animations: {
            if self.textColor == self.errorColor { self.textColor = self.tempColor }
            else { self.tempColor = self.textColor ?? .black }
            self.backgroundView.layer.borderColor = self.hightlighColor.cgColor
            self.backgroundView.layer.borderWidth = 2
            self.errorLabel.alpha = 0
        })
        
        visualDelegate?.didBeginEditing(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let t = self.text ?? ""
        let v = Validate.text(t, type: self.kind)
        
        if (v) {
            UIView.animate(withDuration: Constants.animationDelay, animations: {
                self.backgroundView.layer.borderColor = self.disabledColor.cgColor
                self.backgroundView.layer.borderWidth = 1
                self.errorLabel.alpha = 0
            })
        } else {
            UIView.animate(withDuration: Constants.animationDelay, animations: {
                self.textColor = self.errorColor
                self.backgroundView.layer.borderColor = self.errorColor.cgColor
                self.backgroundView.layer.borderWidth = 2
                self.errorLabel.alpha = 1
            })
        }
        
        visualDelegate?.didEndEditing(self, v)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return inputEnabled
    }
    
    override func shouldChangeText(in range: UITextRange, replacementText text: String) -> Bool {
        return inputEnabled ? super.shouldChangeText(in: range, replacementText: text) : false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        visualDelegate?.didReturn(self)
        return true
    }
}
