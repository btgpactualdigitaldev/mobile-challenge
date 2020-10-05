//
//  DesignSpec.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

/// The description of the Design Specification.
enum DesignSpec {

    /// The specification of each spacing.
    enum Spacing {
        static let `default`: CGFloat = 10
        static let medium: CGFloat = 20
        static let large: CGFloat = 30
    }

    /// The specification of a Button.
    enum Button {
        static let cornerRadius: CGFloat = UIScreen.main.bounds.height * 0.005

        // Constraints
        static let height: CGFloat = 50
        static let widthMultiplier: CGFloat = 0.4
    }

    /// The specification of a Label.
    enum Label {
        static let height: CGFloat = 30
    }

    /// The specification of a TextField.
    enum TextField {
        static let height: CGFloat = 50
    }

    /// The specification of a Result label.
    enum Result {
        static let widthMultiplier: CGFloat = 0.7
        static let height: CGFloat = 50
    }

    enum SegmentedControl {
        static let widthMultiplier: CGFloat = 0.6
        static let heightMultiplier: CGFloat = 0.15
    }
}
