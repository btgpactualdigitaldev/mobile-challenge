//
//  CoinListView.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit
import SnapKit

class CoinListView: UIView {

    // MARK: - Properties
    
    lazy var coinListTableView: CoinListTableView = {
        return CoinListTableView(delegate: viewController)
    }()
    
    weak var viewController: CoinListViewController?
    
    init(viewController: CoinListViewController) {
        self.viewController = viewController
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CoinListView: ViewCoded {
    func setupViewHierarhy() {
        addSubview(coinListTableView)
    }
    
    func setupConstraints() {
        coinListTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
