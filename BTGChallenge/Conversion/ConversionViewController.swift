//
//  ViewController.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 25/03/22.
//

import UIKit

class ConversionViewController: UIViewController {

    let theView: ConversionView
    let userDefault: UserDefaults
    var viewModel: ConversionViewModel

    init(acronym: String, userDefault: UserDefaults = UserDefaults.standard) {
        self.viewModel = ConversionViewModel(acronym: acronym)
        self.theView = ConversionView(viewModel: self.viewModel)
        self.userDefault = userDefault
        super.init(nibName: nil, bundle: nil)
        theView.delegate = self
    }
    
    init(viewModel: ConversionViewModel = ConversionViewModel(acronym: nil), userDefault: UserDefaults = UserDefaults.standard) {
        self.viewModel = viewModel
        self.theView = ConversionView(viewModel: self.viewModel)
        self.userDefault = userDefault
        super.init(nibName: nil, bundle: nil)
        theView.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchQuotes()
    }
    override func loadView() {
        super.loadView()
        theView.delegate = self
        self.view = theView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension ConversionViewController: ConversionDelegate {

    func buttonConvertClicked(valueToConvert: String) {
        viewModel.convert(valueToConvert)
    }
    
    func buttonChoiceCurrencyOneClicked() {
        userDefault.set(true, forKey: "setvalueOne")
        PeformNavigation.navigate(event: ConversionCoordinatorDestinys.search)
    }
    
    func buttonChoiceCurrencyTwoClicked() {
        userDefault.set(true, forKey: "setvalueTwo")
        PeformNavigation.navigate(event: ConversionCoordinatorDestinys.search)
    }
    
}

