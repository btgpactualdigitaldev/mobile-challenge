//
//  BaseView.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 12/12/20.
//

import UIKit

class BaseView: UIView {
    
    var progressView: ProgressView = ProgressView()
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                progressView.show()
            } else {
                progressView.hide()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    required public init() {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    func initialize() {}
    
    func addViews() {}
    
    func autoLayout() {}
    
    override func didMoveToSuperview() {
        autoLayout()
    }
    
    private func setup() {
        backgroundColor = .white
        self.initialize()
        self.addViews()
    }
    
}
