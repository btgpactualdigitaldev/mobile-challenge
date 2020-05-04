//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, ResultViewDelegate, UITextFieldDelegate {
  
  // MARK: - Init
  
  private var rootView : ResultView { return self.view as! ResultView }
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private var viewModel : MainViewModel?
  private var currencyValue = 0.0
  
  override func loadView() {
    self.view = ResultView(frame: UIScreen.main.bounds)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = appDelegate.mainViewModel
    rootView.delegate = self
    rootView.progressSpinner.isHidden = false
    rootView.fromInput.delegate = self
    configureNavigationBar()
    observers()
  }
  
  // MARK: - Configure NavigationBar
  
  private func configureNavigationBar() {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.navigationController?.navigationBar.barTintColor = UIColor(named: "app_primary")
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
    let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor:UIColor.white]
    self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    self.navigationItem.title = "Live Currency"
  }
  
  // MARK: - Handle Button
  
  func textFieldDidChangeSelection(_ textField: UITextField) {
    textField.text = currencyInputFormatting(string: textField.text)
    setResult(value: currencyValue)
  }
  
  func openSelectionViewControler(button: UIButton) {
    let controller = SelectionViewController()
    controller.code = String((button.titleLabel?.text!)!)
    if button == rootView.fromButton {
      controller.type = "FROM"
    } else {
      controller.type = "TO"
    }
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
  // MARK: - Observers
  
  private func observers() {
    viewModel?.liveValue.observe = { (value) in
      // show progress bar
      self.rootView.progressSpinner.isHidden = true
      // set currencyValue var
      self.currencyValue = value
      // set currency result
      self.setResult(value: value)
    }
    viewModel?.error.observe = { (error) in
      // stop progress bar
      self.rootView.progressSpinner.isHidden = true
      // show toast
      self.showToast(message: error)
    }
    viewModel?.fromCode.observe = { (code) in
      // set button title
      self.rootView.fromButton.setTitle(code, for: .normal)
    }
    viewModel?.toCode.observe = { (code) in
      // set button title
      self.rootView.toButton.setTitle(code, for: .normal)
    }
  }
  
  // MARK: - Result
  
  private func setResult(value : Double) {
    let stringText = rootView.fromInput.text
    var finalResult = 0.0
    if (stringText == "") {
      finalResult = 1000 * value
    } else {
      let cleanCommaString = stringText!.replacingOccurrences(of: ",", with: "")
      let cleanDotString = cleanCommaString.replacingOccurrences(of: ".", with: "")
      let parsed = Double(cleanDotString)! / 100
      finalResult = parsed * value
    }
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    rootView.toResult.text = numberFormatter.string(from: NSNumber(value: finalResult))?.substring(from: 1)
  }
  
  // Formatting text for currency input textField
  
  private func currencyInputFormatting(string: String?) -> String {
    if let string = string {
      var number: NSNumber!
      let formatter = NumberFormatter()
      formatter.numberStyle = .currencyAccounting
      formatter.maximumFractionDigits = 2
      formatter.minimumFractionDigits = 2
      var amountWithPrefix = string
      // remove from String: "$", ".", ","
      let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
      amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, string.count), withTemplate: "")
      let double = (amountWithPrefix as NSString).doubleValue
      number = NSNumber(value: (double / 100))
      // if first number is 0 or all numbers were deleted
      guard number != 0 as NSNumber else {
        return ""
      }
      return formatter.string(from: number)!.substring(from: 1)
    } else {
      return ""
    }
  }
  
  
}



