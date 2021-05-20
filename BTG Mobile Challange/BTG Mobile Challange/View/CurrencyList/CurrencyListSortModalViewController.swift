//
//  CurrencyListSortModalViewController.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 25/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import UIKit

class CurrencyListSortModalViewController: UIViewController {

    @IBOutlet weak var sortTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var orderSegmentedControl: UISegmentedControl!


    private weak var sortDelegate: CurrencyListSortProtocol?

    func setup(sortDelegate: CurrencyListSortProtocol) {
        self.sortDelegate = sortDelegate
    }

    private var sortType:CurrencyListSort {
        let sortTypeSelected = sortTypeSegmentedControl.selectedSegmentIndex
        let orderTypeSelected = orderSegmentedControl.selectedSegmentIndex
        let selectedTypes = [sortTypeSelected, orderTypeSelected]

        switch selectedTypes {
        case [0, 0]:
            return .currencyCodeAscending
        case [0, 1]:
            return .currencyCodeDescending
        case [1, 0]:
            return .nameAscending
        case [1, 1]:
            return .nameDescending
        default:
            return .error
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sortDelegate?.didEndSort(sortType: sortType)
    }
}
