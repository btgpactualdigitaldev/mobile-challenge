//
//  AutoLayout.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

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
