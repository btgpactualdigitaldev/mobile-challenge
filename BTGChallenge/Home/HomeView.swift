//
//  HomeView.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 25/03/22.
//

import UIKit
import SnapKit

protocol HomeDelegate: AnyObject {
    func buttonClicked()
}

class HomeView: UIView {
    
    var viewModel: HomeViewModel
    weak var delegate: HomeDelegate?
    
    var stackView: UIStackView
    var titleLabel: UILabel
    var subTitleLabel: UILabel
    var nextButton: UIButton
    
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.stackView = UIStackView()
        self.titleLabel = UILabel()
        self.subTitleLabel = UILabel()
        self.nextButton = UIButton()
        super.init(frame: .zero)
        applyViewCode()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressed() {
        delegate?.buttonClicked()
    }
}

extension HomeView: ViewCodable {
    
    func buildHierarchy() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        addSubview(nextButton)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-40)
            make.left.equalTo(self.snp.left).offset(40)
            make.right.equalTo(self.snp.right).offset(-40)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        stackView.axis  = .vertical
        stackView.distribution  = .fillProportionally
        stackView.alignment = .center
        stackView.spacing   = 5.0
        
        titleLabel.numberOfLines = 0
        titleLabel.text = viewModel.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 45)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        subTitleLabel.numberOfLines = 0
        subTitleLabel.text = viewModel.subtitle
        subTitleLabel.font = UIFont.systemFont(ofSize: 30)
        subTitleLabel.textColor = .black
        subTitleLabel.textAlignment = .center
        
        nextButton.backgroundColor = .systemGray
        nextButton.layer.cornerRadius = 10
        nextButton.setTitle(viewModel.titleButton, for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
}
