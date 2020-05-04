//
//  ResultView.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit

class ResultView: UIView {
  
  // MARK: - Properties
  
  var delegate : ResultViewDelegate?
  
  lazy var progressSpinner : UIActivityIndicatorView = {
    let progressSpinner = UIActivityIndicatorView(style: .large)
    progressSpinner.startAnimating()
    progressSpinner.isHidden = true
    return progressSpinner
  }()
  
  lazy var fromInput : UITextField = {
    let txtField = UITextField()
    txtField.backgroundColor = .clear
    txtField.attributedPlaceholder = NSAttributedString(string: "1,000.00", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
    txtField.font = .systemFont(ofSize: 20)
    txtField.autocorrectionType = .no
    txtField.textColor = .darkGray
    txtField.keyboardType = UIKeyboardType.decimalPad
    txtField.textAlignment = .center
    return txtField
  }()
  
  lazy var toResult : UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.backgroundColor = UIColor(named: "app_accent")
    label.font = .systemFont(ofSize: 20, weight: .bold)
    label.textColor = .darkGray
    return label
  }()
  
  lazy var fromButton : UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("USD", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 16)
    button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    button.semanticContentAttribute = .forceRightToLeft
    button.sizeToFit()
    button.tintColor = .white
    var backgroundLayer = GradientBackground().gl
    backgroundLayer!.frame = frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 100, height: 50))
    button.layer.insertSublayer(backgroundLayer!, at: 0)
    button.addTarget(self, action: #selector(openSelection(_ :)), for: UIControl.Event.touchUpInside)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    return button
  }()
  
  lazy var toButton : UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("BRL", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 16)
    button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    button.semanticContentAttribute = .forceRightToLeft
    button.sizeToFit()
    button.tintColor = .white
    var backgroundLayer = GradientBackground().gl
    backgroundLayer!.frame = frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 100, height: 50))
    button.layer.insertSublayer(backgroundLayer!, at: 0)
    button.addTarget(self, action: #selector(openSelection(_ :)), for: UIControl.Event.touchUpInside)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    return button
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) { // Need receive userModel
    super.init(frame: frame)
    setUpAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setUpAutoLayout() {
    backgroundColor = .white
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    self.addGestureRecognizer(tap)
    
    progressSpinner.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(progressSpinner)
    progressSpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    progressSpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
    self.addSubview(fromButton)
    fromButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      fromButton.heightAnchor.constraint(equalToConstant: 50),
      fromButton.widthAnchor.constraint(equalToConstant: 100),
      fromButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
      fromButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
    
    self.addSubview(fromInput)
    fromInput.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      fromInput.heightAnchor.constraint(equalToConstant: 50),
      fromInput.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
      fromInput.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      fromInput.trailingAnchor.constraint(equalTo: fromButton.leadingAnchor,constant:  -20)])
    
    self.addSubview(toButton)
    toButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      toButton.heightAnchor.constraint(equalToConstant: 50),
      toButton.widthAnchor.constraint(equalToConstant: 100),
      toButton.topAnchor.constraint(equalTo: fromButton.bottomAnchor, constant: 20),
      toButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
    
    self.addSubview(toResult)
    toResult.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      toResult.heightAnchor.constraint(equalToConstant: 50),
      toResult.topAnchor.constraint(equalTo: fromInput.bottomAnchor, constant: 20),
      toResult.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      toResult.trailingAnchor.constraint(equalTo: toButton.leadingAnchor, constant:  -20)])
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    fromInput.underlined()
  }
  
  // MARK: - Handle Buttons
  
  @objc func openSelection(_ sender: UIButton) {
    delegate?.openSelectionViewControler(button :sender)
  }
  
  @objc func dismissKeyboard() {
    fromInput.endEditing(true)
  }
  
}
