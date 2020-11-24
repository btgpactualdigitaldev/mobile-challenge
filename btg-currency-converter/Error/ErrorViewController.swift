//
//  ErrorViewController.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 24/11/20.
//

import SnapKit
protocol ErrorViewControllerDelegate {
    func didClose()
}

class ErrorViewController: UIViewController {
    var delegate: ErrorViewControllerDelegate!
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "error")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Erro inesperado"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .left
        label.textColor = Constant.colorBtg
        label.numberOfLines = 0
        return label
    }()

    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "SF_xmark_square_fill"), for: .normal)
        button.addTarget(self, action: #selector(self.didClose), for: .touchUpInside)
        return button
    }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc
    func didClose()
    {
        delegate?.didClose()
    }

}


//MARK: Default protocol from ViewController
extension ErrorViewController: DefaultView {
    func buildView() {
        self.view.addSubview(backButton)
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(errorLabel)
    }
    
    func setupConstraints() {

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70.0)
            make.width.height.equalTo(20.0)
            make.right.equalToSuperview().inset(30.0)
        }

        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130.0)
            make.width.height.equalTo(100.0)
            make.centerX.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(30.0)
            make.centerX.equalToSuperview()
        }

    }
    
    func setupAditionalConfigurations() {
        self.view.backgroundColor = .white
        
    }
    
}

