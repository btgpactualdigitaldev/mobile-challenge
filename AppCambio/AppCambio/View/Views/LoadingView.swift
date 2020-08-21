//
//  LoadingView.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: @IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblInfo: UILabel!
    
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }
    
    
    // MARK: Methods
    
    class func instanceFromNib() -> LoadingView {
        let loadView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingView
        return loadView
    }
    
    func updateInfo(_ text: String) {
        Thread.isMainThread ? lblInfo.text = text : DispatchQueue.main.async { self.lblInfo.text = text }
    }
}
