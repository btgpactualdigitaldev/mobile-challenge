//
//  GradientBackground.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit

class GradientBackground {
  var gl:CAGradientLayer!
  
  init() {
    let colorTop = UIColor(named: "app_dark")!.cgColor
    let colorBottom = UIColor(named: "app_primary")!.cgColor
    
    self.gl = CAGradientLayer()
    self.gl.colors = [colorTop, colorBottom]
    self.gl.locations = [0.0, 1.0]
    self.gl.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    self.gl.shadowOffset = CGSize(width: 0.0, height: 2.0)
    self.gl.shadowOpacity = 1.0
    self.gl.shadowRadius = 0.0
    self.gl.masksToBounds = false
    self.gl.cornerRadius = 10.0
  }
}
