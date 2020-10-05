//
//  AutoLayout.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

/// Property wrapper responsible for providing a convinient and clean way of
/// making a `UIView` ready for programmatic Auto layout.
/// It only applies to `UIView` that make use of `init(frame: .zero)`.
@propertyWrapper final class AutoLayout<View: UIView> {
    private lazy var view: View = {
        let view = View(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var wrappedValue: View {
        return view
    }
}
