//
//  ViewController.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import UIKit

class ViewController: UIViewController {

    private lazy var quotaView: QuotaView = {
        let quota = QuotaView(frame: .zero)
        quota.translatesAutoresizingMaskIntoConstraints = false
        quota.layer.cornerRadius = 30
        quota.layer.masksToBounds = true
        quota.delegate = self
        
        return quota
    }()
    
    private lazy var viewModel = {
        QuotaViewModel(dataServiceAPI: QuotaAPI())
    }()

    private var siglas: [String]?
    private var nameCoins: [String]? {
        didSet {
            guard let siglas = siglas, let nameCoins = nameCoins else {
                return
            }
            for (sigla,name) in zip(siglas,nameCoins) {
                quotaView.coinsType?.append(sigla + " - " + name)
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .lightGray
        setupView()
        
    }
    
    override func viewDidLayoutSubviews() {
        getCoins()
    }
    
    func getCoins() {
        viewModel.fetchCoins()
        viewModel.didFinishFetchCoins = { [self] in
            siglas = viewModel.siglaCoins
            nameCoins = viewModel.nameCoins
        }
    }
    
    func calculate(from index: IndexPath, to outherIndex: IndexPath, value: Float) {
        guard let siglas = siglas else {
            getCoins()
            return
        }
        
        viewModel.convertToDolar(with: siglas[index.row], value: value)
        viewModel.didFinishConvertToDolar = {
            self.viewModel.fetchQuota(with: siglas[outherIndex.row])
        }
        viewModel.didFinishFetchQuota = { [self] in
            quotaView.newValue = viewModel.newValue ?? 0
        }
    }

}


// MARK: - ViewConding
extension ViewController: ViewCodingProtocol {
    func buildViewHierarchy() {
        self.view.addSubview(quotaView)
    }
    
    func setupConstraints() {
        quotaView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        quotaView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        quotaView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        quotaView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        quotaView.layoutIfNeeded()
        
    }
    
    
}
