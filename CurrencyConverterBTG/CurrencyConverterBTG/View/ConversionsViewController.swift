//
//  ConversionsViewController.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import UIKit

final class ConversionsViewController: UIViewController {
    
    @AutoLayout var originBtn: UIButton
    @AutoLayout var destinyBtn: UIButton
    @AutoLayout var conversionArrow: UIImageView
    @AutoLayout var amountLabel: UILabel
    @AutoLayout var amountTextField: UITextField
    @AutoLayout var resultLabel: UILabel
    @AutoLayout var backgroundLabel: UILabel
    
    var viewModel: ConversionsViewModel
    
    var bottomConstraint = NSLayoutConstraint()
    
    init(viewModel: ConversionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        viewsSetup()
        addConstraints()
        
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.keyboardShowNotification(notification:)),
               name: UIResponder.keyboardWillShowNotification,
               object: nil)
        
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.keyboardHideNotification(notification:)),
               name: UIResponder.keyboardWillHideNotification,
               object: nil)
        
        viewModel.originText.bind { [unowned self] text in
            DispatchQueue.main.async {
                self.originBtn.setTitle(text, for: .normal)
            }
        }
        
        viewModel.destinyText.bind { [unowned self] text in
            DispatchQueue.main.async {
                self.destinyBtn.setTitle(text, for: .normal)
            }
        }
        
        viewModel.resultText.bind { [unowned self] text in
            DispatchQueue.main.async {
                self.resultLabel.text = text
            }
        }
        
        viewModel.amountText.bind { [unowned self] text in
            DispatchQueue.main.async {
                self.amountLabel.text = text
            }
        }
    }
    
    private func viewsSetup() {
        view.backgroundColor = DesignSystem.Color.primary
        
        // Background Label
        backgroundLabel.textColor = DesignSystem.Color.darkPrimary
        backgroundLabel.font = UIFont.systemFont(ofSize: 40)
        let bgString = "CURRENCY $\n CONVERTER"
        let bgAttString = NSMutableAttributedString(string: "CURRENCY $\n CONVERTER")
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: -2, height: 2)
        shadow.shadowBlurRadius = 2
        shadow.shadowColor = DesignSystem.Color.tertiary
        let moneySignAttributes: [NSAttributedString.Key:Any] = [
            .foregroundColor:DesignSystem.Color.moneySign,
            .shadow:shadow
        ]
        bgAttString.addAttributes(moneySignAttributes, range: (bgString as NSString).range(of: "$"))
        backgroundLabel.attributedText = bgAttString
        backgroundLabel.numberOfLines = 2
        
        // Currency Buttons
        originBtn.setTitle("Origin", for: .normal)
        originBtn.tintColor = DesignSystem.Color.white
        originBtn.titleLabel?.numberOfLines = 0
        originBtn.titleLabel?.textAlignment = .center
        originBtn.addTarget(self, action: #selector(didSelectOrigin), for: .touchUpInside)
        originBtn.backgroundColor = DesignSystem.Color.secondary
        originBtn.layer.cornerRadius = DesignSystem.Button.getCornerRadius(view: view)
        
        destinyBtn.setTitle("Destiny", for: .normal)
        destinyBtn.tintColor = DesignSystem.Color.white
        destinyBtn.titleLabel?.numberOfLines = 0
        destinyBtn.titleLabel?.textAlignment = .center
        destinyBtn.addTarget(self, action: #selector(didSelectDestiny), for: .touchUpInside)
        destinyBtn.backgroundColor = DesignSystem.Color.secondary
        destinyBtn.layer.cornerRadius = DesignSystem.Button.getCornerRadius(view: view)
        
        // Currency Arrow
        conversionArrow.image = UIImage(systemName: "arrow.right")
        conversionArrow.tintColor = DesignSystem.Color.tertiary
        
        // Amount label and Text Field
        amountTextField.backgroundColor = DesignSystem.Color.tertiary
        amountTextField.placeholder = "Currency amount..."
        amountTextField.tintColor = DesignSystem.Color.secondary
        amountTextField.attributedPlaceholder = NSAttributedString(string: "$ Amount", attributes: [.foregroundColor : DesignSystem.Color.primary])
        amountTextField.textColor = DesignSystem.Color.white
        amountTextField.borderStyle = .roundedRect
        amountTextField.keyboardType = .numbersAndPunctuation
        amountTextField.delegate = self
        amountTextField.spellCheckingType = .no
        amountTextField.autocorrectionType = .no
        
//        amountLabel.text = ""
        amountLabel.numberOfLines = 0
        amountLabel.textColor = DesignSystem.Color.white
        // Result Label
        resultLabel.textColor = DesignSystem.Color.white
        
        // Add Views
        view.addSubview(backgroundLabel)
        view.addSubview(originBtn)
        view.addSubview(destinyBtn)
        view.addSubview(conversionArrow)
        view.addSubview(amountTextField)
        view.addSubview(amountLabel)
        view.addSubview(resultLabel)
    }
    
    private func addConstraints() {
        // Used by keyboard notification
        self.bottomConstraint = amountLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -DesignSystem.marginsPadding)
        
        NSLayoutConstraint.activate([
            self.bottomConstraint,
            
            // Background Label
            backgroundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: view.frame.width/4),
            
            // Buttons and arrow
            originBtn.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: DesignSystem.marginsPadding),
            destinyBtn.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -DesignSystem.marginsPadding),
            originBtn.widthAnchor.constraint(equalToConstant: DesignSystem.Button.getWidth(view: view)),
            originBtn.heightAnchor.constraint(equalToConstant: DesignSystem.Button.getHeight(view: view)),
            originBtn.bottomAnchor.constraint(equalTo: amountTextField.topAnchor, constant: -DesignSystem.internalPadding),
            destinyBtn.widthAnchor.constraint(equalToConstant: DesignSystem.Button.getWidth(view: view)),
            destinyBtn.heightAnchor.constraint(equalToConstant: DesignSystem.Button.getHeight(view: view)),
            destinyBtn.centerYAnchor.constraint(equalTo: originBtn.centerYAnchor),
            conversionArrow.centerYAnchor.constraint(equalTo: originBtn.centerYAnchor),
            conversionArrow.leftAnchor.constraint(equalTo: originBtn.rightAnchor, constant: DesignSystem.internalPadding),
            conversionArrow.rightAnchor.constraint(equalTo: destinyBtn.leftAnchor, constant: -DesignSystem.internalPadding),
            conversionArrow.widthAnchor.constraint(equalTo: conversionArrow.heightAnchor),
            
            // Text Field and result Label
            amountTextField.leftAnchor.constraint(equalTo: originBtn.leftAnchor),
            amountTextField.rightAnchor.constraint(equalTo: originBtn.rightAnchor),
            amountTextField.bottomAnchor.constraint(equalTo: amountLabel.topAnchor, constant: -DesignSystem.internalPadding),
            amountLabel.leftAnchor.constraint(equalTo: originBtn.leftAnchor),
            amountLabel.rightAnchor.constraint(equalTo: originBtn.rightAnchor),
            
            resultLabel.centerYAnchor.constraint(equalTo: amountTextField.centerYAnchor),
            resultLabel.rightAnchor.constraint(equalTo: destinyBtn.rightAnchor)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        amountTextField.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Objc Methods
extension ConversionsViewController {
    @objc func didSelectOrigin() {
        viewModel.chooseOriringCurrency()
    }
    
    @objc func didSelectDestiny() {
        viewModel.chooseDestinyCurrency()
    }
    
    @objc func keyboardShowNotification(notification: NSNotification) {
        guard let info = notification.userInfo else { return }
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        self.bottomConstraint.constant = -keyboardFrame.size.height - DesignSystem.marginsPadding
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardHideNotification(notification: NSNotification) {
        self.bottomConstraint.constant = -DesignSystem.marginsPadding
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - Text Field Delegate
extension ConversionsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.didUpdateTextField(with: textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
