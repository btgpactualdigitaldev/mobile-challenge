//
//  ViewController.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 19/11/20.
//

import SnapKit

class ViewController: UIViewController {
    
    lazy var homeActionsView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.viewCornerRadius = 10.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.view.addSubview(homeActionsView)
        
        homeActionsView.snp.makeConstraints { make in
            make.top.equalTo(UIScreen.main.bounds.height / 2)
            make.left.right.bottom.equalToSuperview()
        }
        /*
        self.view.backgroundColor = .red
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constant.textConverter
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : Constant.colorBtg]
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = Constant.colorBtg
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "SF_xmark_square_fill")?.resize(toHeight: 20.0),
            style: .plain,
            target: self,
            action: #selector(didBack)
        )
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
 */

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: animated)
        
        UIView.animate(withDuration: 1.0) {
            self.view.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        }
    }
    
    @objc
    fileprivate func didBack() {
        //navigationController?.popViewController(animated: true)
    }

}

