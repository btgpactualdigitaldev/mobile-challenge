//
//  ImpactFeedback.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import UIKit

final class ImpactFeedback {
    static func run(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: style)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
