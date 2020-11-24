//
//  HomeViewController.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 20/11/20.
//

import SnapKit

class HomeViewController: UIViewController {
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundHome")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_positivo")!.resize(toHeight: 70)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.textExchange
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .left
        label.textColor = Constant.colorBtg
        label.numberOfLines = 0
        return label
    }()

    lazy var homeActionsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.viewCornerRadius = 10.0
        return view
    }()

    lazy var convertButton: ButtonBtg = {
        let button = ButtonBtg()
        button.titleLabel.text = Constant.textConverter
        button.iconImageView.image = UIImage(named: "Ion_ios_swap")
        button.buttonAction.addTarget(self, action: #selector(self.didConvert), for: .touchUpInside)
        return button
    }()
    
    lazy var listCoinButton: ButtonBtg = {
        let button = ButtonBtg()
        button.titleLabel.text = Constant.textCoinList
        button.iconImageView.image = UIImage(named: "SF_list_bullet_indent")
        button.buttonAction.addTarget(self, action: #selector(self.didListCoin), for: .touchUpInside)
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
}

extension HomeViewController {
    @objc
    fileprivate func didConvert() {
        let convert = ConvertValueViewController()
        navigationController?.pushViewController(convert, animated: true)
    }
    
    @objc
    fileprivate func didListCoin() {
        let list = ListCoinViewController()
        navigationController?.pushViewController(list, animated: true)
    }
}

//MARK: Default protocol from ViewController
extension HomeViewController: DefaultView {
    func buildView() {
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(logoImageView)
        self.view.addSubview(headerLabel)
        
        self.view.addSubview(homeActionsView)
        self.homeActionsView.addSubview(convertButton)
        self.homeActionsView.addSubview(listCoinButton)
    }
    
    func setupConstraints() {

            backgroundImageView.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.bottom.equalTo(homeActionsView.snp.top).inset(10.0)
            }

            homeActionsView.snp.makeConstraints { make in
                make.bottom.left.right.equalToSuperview()
                make.height.equalTo(UIScreen.main.bounds.height / 4)
            }
            
            logoImageView.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.left.equalToSuperview().inset(10.0)
            }
            
            headerLabel.snp.makeConstraints { make in
                make.top.equalTo(logoImageView.snp.bottom).offset(20.0)
                make.left.equalToSuperview().inset(20.0)
                make.width.equalTo(250.0)
            }
            
            convertButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(50.0)
                make.left.equalToSuperview().inset(70.0)
                make.width.equalTo(100.0)
                make.height.equalTo(105.0)
            }
            
            listCoinButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(50.0)
                make.right.equalToSuperview().inset(70.0)
                make.width.equalTo(100.0)
                make.height.equalTo(105.0)
            }
    }
    
    func setupAditionalConfigurations() {
    }
}

