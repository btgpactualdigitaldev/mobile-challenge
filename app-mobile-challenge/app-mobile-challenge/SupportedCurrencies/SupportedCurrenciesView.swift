//
//  SupportedCurrenciesView.swift
//  app-mobile-challenge
//
//  Created by Matheus Gois on 13/06/21.
//

import UIKit

// Class

final class SupportedCurrenciesView: UIView {

    // Views

    @AutoLayout var backButton: BackButtonView
    @AutoLayout var currentyList: CurrencyList
    @AutoLayout var search: SearchView
    @AutoLayout var titleLabel: TitleLabel

    // Setup

    func setup(
        title: String
    ) {
        self.titleLabel.text = title
        setupConstraints()
        setupViews()
    }

    func setupViews() {
        self.backgroundColor = DesignSystem.Colors.background
    }
}

// Build Views

fileprivate extension SupportedCurrenciesView {
    func setupConstraints() {
        layoutButton()
        layoutTitle()
        layoutSearch()
        layoutCurrentyList()
    }

    func layoutButton() {
        addSubview(backButton)
        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.large),
            backButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Back.height),
            backButton.widthAnchor.constraint(equalToConstant: DesignSystem.Button.Back.width)
        ])
    }

    func layoutTitle() {
        addSubview(titleLabel)
        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.large),
            titleLabel.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor)
        ])
    }

    func layoutSearch() {
        addSubview(search)
        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: DesignSystem.Spacing.large*2),
            search.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),
            search.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor)
        ])
    }

    func layoutCurrentyList() {
        addSubview(currentyList)
        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            currentyList.topAnchor.constraint(equalTo: search.bottomAnchor, constant: DesignSystem.Spacing.large),
            currentyList.bottomAnchor.constraint(equalTo: layoutGuides.bottomAnchor),
            currentyList.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),
            currentyList.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor)
        ])
    }
}
