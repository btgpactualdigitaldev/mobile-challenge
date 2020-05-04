//
//  SelectionCell.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit

class SelectionViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    return label
  }()
  
  // MARK: - Init
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    
    addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)])
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let backgroundLayer = GradientBackground().gl
    backgroundLayer!.frame = frame(forAlignmentRect: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 60))
    self.layer.insertSublayer(backgroundLayer!, at: 0)
    titleLabel.frame = titleLabel.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}



