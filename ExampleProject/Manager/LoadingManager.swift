//
//  LoadingManager.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 07/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

class LoadingManager: UIViewController {
    //MARK: Attributes
    
    let modalView: UIView = {
        let vw = UIView()
        vw.backgroundColor = .white
        vw.layer.cornerRadius = 12
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        iv.hidesWhenStopped = true
        iv.style = UIActivityIndicatorView.Style.medium
        iv.startAnimating();
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let loadingLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Aguarde..."
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    static let shared = LoadingManager()
    var isPresenting = false
    
    //MARK: View LifeCycle
    private init() {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overCurrentContext
        self.isModalInPresentation = true
        self.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)

        setupConstrains()
    }
    
    //MARK: Functions
    fileprivate func setupConstrains() {
        self.view.addSubview(modalView)
        modalView.addSubview(loadingIndicator)
        modalView.addSubview(loadingLabel)
        
        modalView.centerXAnchor.anchor(self.view.centerXAnchor)
        modalView.centerYAnchor.anchor(self.view.centerYAnchor)
        
        loadingIndicator.leftAnchor.anchor(modalView.leftAnchor, 8)
        loadingIndicator.topAnchor.anchor(modalView.topAnchor, 8)
        loadingIndicator.bottomAnchor.anchor(modalView.bottomAnchor, -8)

        loadingLabel.centerYAnchor.anchor(loadingIndicator.centerYAnchor)
        loadingLabel.leftAnchor.anchor(loadingIndicator.rightAnchor, 16)
        loadingLabel.rightAnchor.anchor(modalView.rightAnchor, -8)
    }
    
    
    func dismiss(_ callback: @escaping () -> Void = {}) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: callback)
        }
    }
}
