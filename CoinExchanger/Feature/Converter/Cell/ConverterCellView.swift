//
//  ConverterCellView.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import UIKit

class ConverterCellView: UIView {
    weak var delegate: GenericDelegate?
    weak var visualDelegate: VisualInputDelegate? {
        didSet { inputField.visualDelegate = visualDelegate } }
    
    override var tag: Int {
        didSet { button.tag = tag ; inputField.tag = tag } }
    
    // MARK: View
    let label: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Moderat-Bold", size: 17)
        label.textAlignment = .center
        label.textColor = Asset.Colors.gray.color
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("$", for: .normal)
        button.tintColor = Asset.Colors.secondary.color
        button.titleLabel?.font = UIFont(name: "Moderat-Thin", size: 20)
        button.widthAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        return button
    }()
    
    let inputField: VisualInputValue = {
        let field = VisualInputValue()
        field.backgroundView.backgroundColor = Asset.Colors.surface.color
        field.font = UIFont(name: "Moderat-Regular", size: 24)
        field.hightlighColor = Asset.Colors.primary.color
        field.textColor = Asset.Colors.text.color
        return field
    }()
    
    // MARK: Override
    convenience init(_ labelText: String?, _ buttonText: String?, _ inputHint: String?) {
        self.init()
        set(labelText, buttonText, inputHint)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Set
    func set(_ labelText: String?, _ buttonText: String?, _ inputHint: String?) {
        label.text = labelText
        button.setTitle(buttonText, for: .normal)
        inputField.attributedPlaceholder = NSAttributedString(string: inputHint ?? "", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}

private extension ConverterCellView {
    // MARK: Setup
    func setup() {
        addSubview(label)
        label.top(equalTo: self)
        label.fillHorizontal(to: self)
        
        addSubview(button)
        button.topToBottom(of: label, constant: Constants.space/4)
        button.centerX(equalTo: self)
        
        addSubview(inputField)
        inputField.topToBottom(of: button, constant: Constants.space/4)
        inputField.fillHorizontal(to: self)
        inputField.bottom(equalTo: self)
        inputField.height(constant: 48)
        
        button.addTarget(self, action: #selector(didTouch(_:)), for: .touchUpInside)
    }
    
    @objc
    func didTouch(_ view: UIView) {
        delegate?.didTouch(view)
    }
}
