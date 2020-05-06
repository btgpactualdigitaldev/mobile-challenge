//
//  Drawable.swift
//  Screens
//
//  Created by Gustavo Amaral on 29/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

protocol Drawable: AnyObject {
    func makeConstraints()
    func stylizeViews()
    func createViewsHierarchy()
}

extension Drawable {
    func makeConstraints() { }
    func stylizeViews() { }
    func createViewsHierarchy() { }
    
    func draw() {
        createViewsHierarchy()
        stylizeViews()
        makeConstraints()
    }
}
