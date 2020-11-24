//
//  ButtonBtg.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 21/11/20.
//

import SnapKit

class ButtonBtg: UIView {
    lazy var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        return view
    }()

    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textAlignment = .center
        label.textColor = UIColor.init(red: 29/255, green: 35/255, blue: 67/255, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var buttonAction: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(red: 208/255, green: 210/255, blue: 214/255, alpha: 1.0).cgColor
        self.layer.cornerRadius = 10.0
        
        self.layer.shadowColor = UIColor(red: 235/255, green: 236/255, blue: 237/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5.0
        
        self.addSubview(bgView)
        bgView.addSubview(iconImageView)
        bgView.addSubview(titleLabel)
        self.addSubview(buttonAction)
        
        bgView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        buttonAction.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(30.0)
            
        }
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(10.0)
        }
    }
}
