//
//  FloatingActionButton.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import UIKit

@propertyWrapper class FloatingActionButton<T: CustomButton> {

    var onTouch: () -> Void = { }

    private lazy var fab: T = {
        let fab = T(type: .custom)
        fab.translatesAutoresizingMaskIntoConstraints = false

        fab.layer.shadowColor = DesignSystem.Color.shadow.cgColor
        fab.layer.shadowOffset = DesignSystem.FloatingActionButton.shadowOffset
        fab.layer.shadowOpacity = DesignSystem.FloatingActionButton.shadowOpacity
        fab.layer.shadowRadius = DesignSystem.FloatingActionButton.shadowRadius
        fab.layer.cornerRadius = DesignSystem.FloatingActionButton.cornerRadius

        fab.backgroundColor = DesignSystem.Color.action
        fab.tintColor = .white
        fab.setImage(DesignSystem.Image.invert, for: .normal)

        fab.contentVerticalAlignment = .fill
        fab.contentHorizontalAlignment = .fill
        fab.imageView?.contentMode = .scaleAspectFit
        fab.imageEdgeInsets = DesignSystem.FloatingActionButton.edgeInsets

        fab.addAction(UIAction(handler: { [weak self] _ in
            self?.onTouch()
        }), for: .touchUpInside)

        NSLayoutConstraint.activate([
            fab.widthAnchor.constraint(equalToConstant: DesignSystem.FloatingActionButton.size),
            fab.heightAnchor.constraint(equalToConstant: DesignSystem.FloatingActionButton.size)
        ])

        return fab
    }()

    var wrappedValue: T {
        return fab
    }
}
