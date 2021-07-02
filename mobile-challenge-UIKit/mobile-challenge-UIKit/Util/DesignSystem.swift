//
//  DesignSystem.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import UIKit

struct DesignSystem {

    struct Spacing {
        static let `default`: CGFloat = 10
        static let leadingTopSafeArea: CGFloat = 20
        static let trailingBottomSafeArea: CGFloat = -20
        static let min: CGFloat = 2
    }

    struct Color {
        static let background: UIColor = .systemBackground
        static let border: UIColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        static let currencyCodeView: UIColor = UIColor(named: "currencyCodeView") ?? .clear
        static let primaryText: UIColor = .label
        static let gray: UIColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        static let secondaryText: UIColor = UIColor(named: "secondaryText") ?? .secondaryLabel
        static let action: UIColor = #colorLiteral(red: 0.09803921569, green: 0.3529411765, blue: 0.7058823529, alpha: 1)
        static let shadow: UIColor = .label
    }

    struct FontSize {
        static let normal: CGFloat = 18
        static let large: CGFloat = 24
        static let labelTitle: CGFloat = 17
        static let labelDetails: CGFloat = 15
        static let fab: CGFloat = 30
    }

    struct Animation {
        static let duration: TimeInterval = 0.2
        static let lowAlpha: CGFloat = 0.3
        static let highAlpha: CGFloat = 1
    }

    struct TextField {
        static let height: CGFloat = 68
        static let width: CGFloat = UIScreen.main.bounds.width
        static let cornerRadius: CGFloat = min(height, width) / 2
        static let borderWidth: CGFloat = 1
        static let padding = UIEdgeInsets(top: 0,
                                          left: CurrencyCodeView.width + 10,
                                          bottom: 0,
                                          right: 20)
        static let editingPadding = UIEdgeInsets(top: 0,
                                          left: CurrencyCodeView.width + 10,
                                          bottom: 0,
                                          right: 40)
    }

    struct CurrencyCodeView {
        static let x: CGFloat = 9
        static let y: CGFloat = 7.5
        static let width: CGFloat = UIScreen.main.bounds.width / 4
        static let height: CGFloat = TextField.height - y * 2
        static let frame: CGRect = CGRect(x: x, y: y, width: width, height: height)
        static let cornerRadius = min(width, height) / 2
    }

    struct InputAccessoryView {
        static let x: CGFloat = .zero
        static let y: CGFloat = .zero
        static let width: CGFloat = UIScreen.main.bounds.width
        static let height: CGFloat = 40
        static let frame: CGRect = CGRect(x: x, y: y, width: width, height: height)
    }

    struct InputAccessoryViewButton {
        static let x: CGFloat = UIScreen.main.bounds.width - width
        static let y: CGFloat = .zero
        static let width: CGFloat = 80
        static let height: CGFloat = InputAccessoryView.height
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }

    struct FloatingActionButton {
        static let size: CGFloat = 65
        static let cornerRadius: CGFloat = size / 2
        static let shadowOffset: CGSize = CGSize(width: 0, height: 1)
        static let shadowRadius: CGFloat = 4
        static let shadowOpacity: Float = 0.5
        static let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 13,
                                                           left: 13,
                                                           bottom: 13,
                                                           right: 13)
    }

    struct Image {
        static let chevronRight = UIImage(systemName: "chevron.right")
        static let invert = UIImage(systemName: "arrow.triangle.2.circlepath")
    }
}
