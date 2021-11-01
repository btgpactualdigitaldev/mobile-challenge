//
//  ExceptionViewController.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 30/10/21.
//

import UIKit

class ExceptionViewController: UIViewController, Storyboarded {
    //MARK: - Outlets
    @IBOutlet weak var imageError: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Error attribute
    var error: ServiceError?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageError.image = error?.image
        descriptionLabel.text = error?.localizedDescription
    }
}
