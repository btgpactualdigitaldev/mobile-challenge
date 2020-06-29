//
//  OrderingView.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 28/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SortView: UIView {
    
    private unowned var segmentedControl: UISegmentedControl
    private unowned var textField: UITextField
    
    private lazy var sortLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private let idText = "Por código"
    private let fullNameText = "Por nome"
    
    init(frame: CGRect,
         segmentedControl: UISegmentedControl,
         textField: UITextField) {
        self.segmentedControl = segmentedControl
        self.textField = textField
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SortView: ViewCodeProtocol {
    
    func buildHierarchy() {
        addSubview(segmentedControl)
        addSubview(sortLbl)
        addSubview(textField)
    }
    
    func setupConstraints() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: segmentedControl,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: segmentedControl,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: -1).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        sortLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: sortLbl,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: segmentedControl,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: sortLbl,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        sortLbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: textField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 100).isActive = true
        NSLayoutConstraint(item: textField,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func configureViews() {
        segmentedControl.insertSegment(withTitle: idText, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: fullNameText, at: 1, animated: true)
        segmentedControl.backgroundColor = .currencyTableViewCellBackgrouncColor
        segmentedControl.tintColor = .currencyTableViewCellLayerColor
        segmentedControl.selectedSegmentTintColor = .currencyTableViewCellLayerColor
        segmentedControl.selectedSegmentIndex = 0
        
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 4
        textField.textAlignment = .center
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Digite a moeda que deseja buscar", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x808080)])
        
        sortLbl.text = "Ordenar por"
        sortLbl.textColor = .convertButtonLayerColor
        sortLbl.textAlignment = .center
    }
}
