//
//  CurrencyListCell.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class CurrencyListCell: UITableViewCell {

    // Views

    @AutoLayout private var starButton: UIButton
    @AutoLayout private var codeLabel: TitleLabel
    @AutoLayout private var nameLabel: SubtitleLabel

    // Properties

    private var currency: List?
    private var indexPath = IndexPath()
    
    var toggleAction: ((_ index: IndexPath)->Void)? = nil
    var selectedAction: ((_ index: IndexPath)->Void)? = nil

    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupViews()
        layoutViews()
    }

    // Methods

    public func setup(currency: List, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.currency = currency
        codeLabel.text = currency.code
        codeLabel.font = TextStyle.display4.font
        nameLabel.text = currency.name
        setupStar(favorite: currency.favorite)
        backgroundColor = DesignSystem.Colors.background
        if isCellSelected() { isSelected = true }
    }
    
    // Private Methods

    private func setupViews() {
        style()
        setupButton()
    }
    
    private func layoutViews() {
        layoutButton()
        layoutTitle()
        layoutSubtitle()
    }

    private func setupButton() {
        starButton.backgroundColor = DesignSystem.Colors.background
        starButton.layer.cornerRadius = 14
        starButton.clipsToBounds = true
    }

    private func setupStar(favorite: Bool?) {
        if favorite ?? false {
            starButton.setImage(DesignSystem.Icons.star_fill, for: .normal)
        } else {
            starButton.setImage(DesignSystem.Icons.star, for: .normal)
        }
    }

    private func toggle() {
        toggleAction?(indexPath)
    }

    private func selected() {
        selectedAction?(indexPath)
    }

    private func getCurrencyCodeSelected(type: String) -> String? {
        var value = ""
        switch type {
        case "from":
            value = CommonData.shared.fromCurrencyStorage
        case "to":
            value = CommonData.shared.toCurrencyStorage
        default:
            return nil
        }
        return value
    }

    private func isCellSelected() -> Bool {
        let type = CommonData.shared.selectedTypeCurrency
        guard let code = getCurrencyCodeSelected(type: type) else { return false }
        return currency?.code == code
    }

    private func style() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        selectionStyle = .none
    }

    private func layoutButton() {
        addSubview(starButton)
        let layoutGuides = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            starButton.centerYAnchor.constraint(equalTo: layoutGuides.centerYAnchor),
            starButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            starButton.widthAnchor.constraint(equalToConstant: 48),
            starButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    private func layoutTitle() {
        addSubview(codeLabel)
        let layoutGuides = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.default),
            codeLabel.leadingAnchor.constraint(equalTo: starButton.trailingAnchor, constant: DesignSystem.Spacing.default)
        ])
    }

    private func layoutSubtitle() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: starButton.trailingAnchor, constant: DesignSystem.Spacing.default)
        ])
    }

    // Overrides

    override var isSelected: Bool {
        didSet {
            alpha = isSelected ? 0.5 : 1.0
        }
    }

    override func touchesEnded(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        if let touch = touches.first {
            if starButton.bounds.contains(touch.location(in: self)) {
                toggle()
            } else if bounds.contains(touch.location(in: self)) {
                selected()
            }
        }
    }
}
