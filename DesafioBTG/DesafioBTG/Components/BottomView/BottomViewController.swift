//
//  BottomViewController.swift
//  DesafioBTG
//
//  Created by Any Ambria on 13/12/20.
//  Copyright © 2020 Any Ambria. All rights reserved.
//

import UIKit

class BottomViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton?
    @IBOutlet weak var pikerView: UIPickerView?

    weak var delegate: UIPickerViewDelegate?
    weak var dataSource: UIPickerViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pikerView?.delegate = delegate
        pikerView?.dataSource = dataSource
        
    }
    
    init(delegate: UIPickerViewDelegate, dataSource: UIPickerViewDataSource) {
        self.delegate = delegate
        self.dataSource = dataSource
        super.init(nibName: "BottomViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPicker(delegate: UIPickerViewDelegate, dataSource: UIPickerViewDataSource) {
        pikerView?.delegate = delegate
        pikerView?.dataSource = dataSource
        pikerView?.reloadAllComponents()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


