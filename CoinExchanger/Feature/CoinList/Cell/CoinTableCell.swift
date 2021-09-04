//
//  CoinTableCell.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 03/09/21.
//

import UIKit

class CoinTableCell: UITableViewCell, ReusableView {
    override var tag: Int { didSet { animatedButton.tag = tag } }
    var tapAction: (_ view: UIView)-> Void = {_ in }
    
    // MARK: View
    let animatedButton: AnimatedButton = {
        let button = AnimatedButton(.replace)
        //button.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        button.animatedBackgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return button
    }()
    
    let coinName: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Moderat-Medium", size: 20)
        label.textColor = Asset.Colors.text.color
        return label
    }()
    
    let coinID: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Moderat-Regular", size: 16)
        label.textColor = Asset.Colors.gray.color
        return label
    }()
    
    // MARK: Override
    override func prepareForReuse() {
        coinName.text = ""
        coinID.text = ""
        tag = 0
        tapAction = {_ in}
    }
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Set
    func set(_ code: String?, _ name: String?) {
        coinName.text = name
        coinID.text = code
    }
    
    func set(_ coin: Coin) {
        coinName.text = coin.name
        coinID.text = coin.code
    }
}

private extension CoinTableCell {
    // MARK: Setup
    func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        imageView?.removeFromSuperview()
        textLabel?.removeFromSuperview()
        
        addSubview(animatedButton)
        animatedButton.fill(to: self)
        
        animatedButton.addSubview(coinName)
        coinName.top(equalTo: animatedButton, constant: Constants.space)
        coinName.fillHorizontal(to: animatedButton, constant: Constants.space)
        
        animatedButton.addSubview(coinID)
        coinID.topToBottom(of: coinName, constant: Constants.space/4)
        coinID.fillHorizontal(to: animatedButton, constant: Constants.space*2)
        coinID.bottom(equalTo: animatedButton, constant: -Constants.space)
        
        animatedButton.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
    }
    
    @objc
    private func didTap(_ button: UIButton) {
        tapAction(button)
    }
}
