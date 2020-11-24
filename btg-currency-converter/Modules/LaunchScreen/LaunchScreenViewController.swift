//
//  LaunchScreenViewController.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 19/11/20.
//

import SnapKit

class LaunchScreenViewController: UIViewController {
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoLaunchScreen")!.resize(toHeight: 100)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var logoCircle: CircleBtg = {
        return CircleBtg(frame: CGRect(x: CGFloat(Int(arc4random_uniform(7))*50), y: 0, width: CGFloat(102), height: CGFloat(102)))
    }()
    
    lazy var backBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = Constant.colorBtg
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoCircle.animateCircle(duration: 1.5)
    }
}

//MARK: Default protocol from ViewController
extension LaunchScreenViewController: DefaultView {
    func buildView() {
        self.view.addSubview(logoCircle)
        self.view.addSubview(backBoxView)
        self.view.addSubview(logoImageView)
    }
    
    func setupConstraints() {
        backBoxView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.top).inset(25.0)
            make.left.equalTo(logoImageView.snp.left).inset(80.0)
            make.width.equalTo(15.0)
            make.height.equalTo(45.0)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        logoCircle.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.top).inset(47.0)
            make.left.equalTo(logoImageView.snp.left).inset(47.0)
        }
    }
    
    func setupAditionalConfigurations() {
        self.view.backgroundColor = Constant.colorBtg
        self.logoCircle.delegate = self
    }
}

extension LaunchScreenViewController: CircleBtgDelegate {
    func didStopAnimation() {
        let homeViewController = HomeViewController()
        let nav1 = UINavigationController()
        let mainView = homeViewController
        nav1.viewControllers = [mainView]
        
        UIApplication.shared.windows.first?.rootViewController = nav1
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
