//
//  LoadingCell.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 28/11/20.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    static let identifier = "LoadingCellID"
    
    var loadingView: LoadingView = {
        var loading = LoadingView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    func setUpCell() {
        setUpViews()
    }

}

extension LoadingCell: ViewCodable {
    func setUpHierarchy() {
        contentView.addSubview(loadingView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setUpAditionalConfiguration() {
        selectionStyle = .none
        loadingView.backgroundColor = AppColors.appBackground.color
    }

}
