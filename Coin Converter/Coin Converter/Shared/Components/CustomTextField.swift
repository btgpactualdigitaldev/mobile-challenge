//
//  CustomTextField.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import UIKit

enum TextFieldPadding {
    case `default`
    case custom(UIEdgeInsets)
    case floatingLabel(CGFloat)
    
    var inset: UIEdgeInsets {
        switch self {
        case .default:
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        case .custom(let insets):
            return insets
        case .floatingLabel(let rightValue):
            return UIEdgeInsets(top: 16, left: 8, bottom: 0, right: rightValue)
        }
    }
}

class CustomTextField: UITextField {
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let customButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    private let customPlaceholderLabel: UILabel = UILabel(frame: .zero)
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var onCustomButtonTouch: (() -> Void)?
    
    override var text: String? {
        didSet {
            textDidChange()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            configureEnable(withEnabled: isEnabled)
        }
    }
    
    var padding: TextFieldPadding = .default {
        didSet {
            layoutIfNeeded()
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding.inset)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding.inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding.inset)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 10
        return rect
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//*************************************************
// MARK: - Action
//*************************************************

extension CustomTextField {
    @objc private func textDidChange() {
        guard text != nil else { return }
        updateCustomPlaceholder()
    }
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension CustomTextField {
    
    func configureCustomButton(image: UIImage, imageSize: CGFloat = 0) {
        customButton.setImage(image, for: .normal)
        customButton.contentEdgeInsets =  UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        customButton.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        customButton.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        customButton.addTarget(self, action: #selector(customButtonTouched), for: .touchUpInside)
        customButton.isEnabled = isEnabled
        rightView = customButton
        rightViewMode = .always
    }
}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension CustomTextField {
    
    private func setupView() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: self)

        setupCustomPlaceholder()
        setupBottomBorder()
        backgroundColor = UIColor(hexadecimal: 0xFAFAFA)
        font = UIFont.systemFont(ofSize: 14)
        layer.masksToBounds = true
    }
    
    private func setupBottomBorder() {
        let bottomLine: CALayer = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
    private func setupCustomPlaceholder() {
        addSubview(customPlaceholderLabel)
        customPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        customPlaceholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding.inset.left).isActive = true
        customPlaceholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding.inset.right).isActive = true
        customPlaceholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        customPlaceholderLabel.backgroundColor = UIColor.clear
        customPlaceholderLabel.font = UIFont.boldSystemFont(ofSize: 14)
        customPlaceholderLabel.textColor = .blue
    }
    
    private func configureEnable(withEnabled isEnabled: Bool) {
        alpha = isEnabled ? 1 : 0.5
        isUserInteractionEnabled = isEnabled
    }
    
    @objc private func customButtonTouched() {
        onCustomButtonTouch?()
    }
    
    private func updateCustomPlaceholder() {
        customPlaceholderLabel.text = placeholder
        let hasPlaceholder = !(placeholder ?? "").isEmpty
        let hasText = !(text ?? "").isEmpty
        if hasPlaceholder && hasText {
            UIView.animate(withDuration: 0.6) {
                self.customPlaceholderLabel.alpha = 1
            }
            updateRightSpace()
        } else {
            customPlaceholderLabel.alpha = 0
            padding = .default
        }
    }
    
    private func updateRightSpace() {
        let totalRight: CGFloat = rightViewMode == .always ? 44.0 : 8.0
        padding = .floatingLabel(totalRight)
    }
}
