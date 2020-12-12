//
//  CurrenciesViewController.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 08/12/20.
//

import UIKit

class SupportedCurrenciesViewController: UIViewController, Storyboarded {

    static func instantiate() -> Self? { return SupportedCurrenciesViewController() as? Self}
    var  viewModel: SupportedCurrenciesViewModel?
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.initSupportedCurrenciesScreen(tableView: tableView)
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Strings.SupportedCurrenciesScreen.title
            titleLabel.tintColor = Colors.primaryColor
        }
    }

    @IBAction func onPressBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tintColor = Colors.primaryColor
        }
    }
}
