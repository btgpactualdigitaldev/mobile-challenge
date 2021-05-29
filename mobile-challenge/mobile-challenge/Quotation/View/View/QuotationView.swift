//
//  QuotationView.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class QuotationView: UIView {
    
    private var backgroundTopView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = QuotationColors.topBackground.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var middleView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = AppColors.appBackground.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var chooseCurrencyView: ChooseCurrencyView = {
        let stack = ChooseCurrencyView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var convertButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("CONVERT", for: .normal)
        let textColor = QuotationColors.buttonTextColor.color
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = QuotationColors.convertButton.color
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuotationView: ViewCodable {
    func setUpHierarchy() {
        addSubview(backgroundTopView)
        addSubview(middleView)
        middleView.addSubview(chooseCurrencyView)
        addSubview(convertButton)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            backgroundTopView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundTopView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundTopView.topAnchor.constraint(equalTo: topAnchor),
            backgroundTopView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.4),
            
            middleView.heightAnchor.constraint(equalToConstant: 230),
            middleView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.9),
            middleView.centerYAnchor.constraint(equalTo: backgroundTopView.bottomAnchor),
            middleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            chooseCurrencyView.topAnchor.constraint(equalTo: middleView.topAnchor, constant: 20),
            chooseCurrencyView.centerXAnchor.constraint(equalTo: centerXAnchor),
            chooseCurrencyView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.8),
            chooseCurrencyView.heightAnchor.constraint(equalToConstant: 180),
            
            convertButton.centerYAnchor.constraint(equalTo: middleView.bottomAnchor),
            convertButton.widthAnchor.constraint(equalToConstant: 190),
            convertButton.heightAnchor.constraint(equalToConstant: 50),
            convertButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func setUpAditionalConfiguration() {
        backgroundColor = .white
        
        applyShaddow(view: middleView)
        applyShaddow(view: convertButton)
    }
    
    func applyShaddow(view: UIView) {
        view.layer.shadowColor = .init(gray: 0.0, alpha: 0.5)
        view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5.0
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 5.0
    }
}
