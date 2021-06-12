//
//  ShimerHelper.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

internal final class ShimmerHelper {
    static func startLoadingSkeleton(with label: UILabel) {
        let subMaskView = ViewWhite()
        let maskView = ViewShimmering()
        label.addSubview(subMaskView)
        label.addSubview(maskView)
        subMaskView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subMaskView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            subMaskView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            subMaskView.topAnchor.constraint(equalTo: label.topAnchor),
            subMaskView.bottomAnchor.constraint(equalTo: label.bottomAnchor),
        ])
        maskView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maskView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            maskView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            maskView.topAnchor.constraint(equalTo: label.topAnchor),
            maskView.bottomAnchor.constraint(equalTo: label.bottomAnchor),
        ])
        
        label.startShimmer()
    }
}

internal class ViewWhite: UIView {
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal class ViewShimmering: UIView {
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
