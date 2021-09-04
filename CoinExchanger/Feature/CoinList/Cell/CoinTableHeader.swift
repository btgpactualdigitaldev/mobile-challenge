//
//  CoinTableHeader.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import UIKit

class CoinTableHeader: UIView {
    weak var visualDelegate: VisualInputDelegate? {
        didSet { searchField.visualDelegate = visualDelegate }}
    
    // MARK: View
    let searchField: VisualInputSearch = {
        let field = VisualInputSearch()
        field.accessibilityHint = L10n.Coin.List.searchHint
        field.attributedPlaceholder = NSAttributedString(string: L10n.Coin.List.search, attributes: [ NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        field.backgroundView.backgroundColor = Asset.Colors.surface.color
        field.font = UIFont(name: "Moderat-Regular", size: 24)
        field.hightlighColor = Asset.Colors.primary.color
        field.kind = .none
        field.tag = 1
        field.textColor = Asset.Colors.text.color
        return field
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray.color.withAlphaComponent(0.8)
        view.isUserInteractionEnabled = false
        view.height(constant: 2)
        return view
    }()
    
    // MARK: Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

private extension CoinTableHeader {
    // MARK: Setup
    func setup() {
        backgroundColor = Asset.Colors.background.color
        
        addSubview(searchField)
        searchField.fill(to: self, constant: Constants.space)
        searchField.height(constant: 56)
        
        addSubview(divider)
        divider.fillHorizontal(to: self)
        divider.bottom(equalTo: self)
    }
}
