//
//  AboutTheDevViewController.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 20/05/21.
//

import UIKit
import SafariServices

class AboutTheDevViewController: UIViewController {
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var stackoverflowButton: UIButton!
    @IBOutlet weak var codewarsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavigationBar()
        
        self.configureButtons()
    }
    
    private func configureButtons() {
        self.linkedinButton.imageView?.layer.cornerRadius = self.linkedinButton.bounds.height / 2.0
        self.githubButton.imageView?.layer.cornerRadius = self.githubButton.bounds.height / 2.0
        self.stackoverflowButton.imageView?.layer.cornerRadius = self.stackoverflowButton.bounds.height / 2.0
        self.codewarsButton.imageView?.layer.cornerRadius = self.codewarsButton.bounds.height / 2.0        
    }
    
    
    @IBAction func linkedinButtonTapped(_ sender: UIButton) {
        if let safeLinkedinURL = URL(string: Constants.LINKEDIN_URL_STRING) {
            self.open(pageURL: safeLinkedinURL)
        }
    }
    
    @IBAction func githubButtonTapped(_ sender: UIButton) {
        if let safeGithubURL = URL(string: Constants.GITHUB_URL_STRING) {
            self.open(pageURL: safeGithubURL)
        }
    }
    
    @IBAction func stackoverflowButtonTapped(_ sender: UIButton) {
        if let safeStackoverflowURL = URL(string: Constants.STACKOVERFLOW_URL_STRING) {
            self.open(pageURL: safeStackoverflowURL)
        }
    }
    
    @IBAction func codewarsButtonTapped(_ sender: UIButton) {
        if let safeCodewarsURL = URL(string: Constants.CODEWARS_URL_STRING) {
            self.open(pageURL: safeCodewarsURL)
        }
    }
    
    private func open(pageURL: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let viewController = SFSafariViewController(url: pageURL, configuration: config)
        present(viewController, animated: true)
    }
}
