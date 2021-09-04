//
//  RegularBackButton.swift
//  CoinExchanger
//
//  Created by Edson Rottava on 18/08/21.
//

import UIKit

class RegularBackButton: UIBarButtonItem {
  @available(iOS 14.0, *)
  override var menu: UIMenu? {
    set {
      /* Don't set the menu here */
      /* super.menu = menu */
    }
    get {
      return super.menu
    }
  }
}
