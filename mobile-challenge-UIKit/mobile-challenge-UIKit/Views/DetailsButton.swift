//
//  DetailsButton.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import UIKit

@propertyWrapper class DetailsButton<T: CustomButton> {

    var onTouch: () -> Void = { }
    private(set) var currencyType: CurrencyConverterViewModel.CurrencyType

    private lazy var view: T = {
        let view = T(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false

        let imageView = UIImageView(image: DesignSystem.Image.chevronRight)
        imageView.tintColor = DesignSystem.Color.primaryText
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [labelsStackView, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.isUserInteractionEnabled = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.addAction(UIAction(handler: { [weak self] _ in
            self?.onTouch()
        }), for: .touchUpInside)

        return view
    }()

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = DesignSystem.Spacing.min

        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: DesignSystem.FontSize.labelTitle)
        label.textColor = DesignSystem.Color.primaryText
        label.text = currencyType == .origin
            ? LiteralText.originViewControllerTitle
            : LiteralText.targetViewControllerTitle
        
        return label
    }()

    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: DesignSystem.FontSize.labelDetails)
        label.textColor = DesignSystem.Color.secondaryText

        return label
    }()

    var wrappedValue: T {
        return view
    }

    init(_ currencyType: CurrencyConverterViewModel.CurrencyType) {
        self.currencyType = currencyType
    }

    /// Sets detailsLabel text
    /// - Parameter text: detailsLabel text
    func setDetailsLabel(text: String) {
        detailsLabel.text = text
    }
}
