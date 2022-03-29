//
//  SearchBarViewController.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 26/03/22.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func textDidChangeSearchBar(_ text: String, _ scope: Int)
    func textDidChangeSearchController(_ text: String, _ scope: Int)
}

extension SearchBarDelegate {
    func textDidChangeSearchBar(_ text: String, _ scope: Int) {}
    func textDidChangeSearchController(_ text: String, _ scope: Int) {}
}

class SearchBarViewController: UISearchController {

    var buttonScopes: [String] = []
    weak var delegateSearch: SearchBarDelegate?
    
    init(buttonScopes: [String], _ delegate: SearchBarDelegate) {
        self.buttonScopes = buttonScopes
        self.delegateSearch = delegate
        super.init(searchResultsController: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResultsUpdater = self
        self.obscuresBackgroundDuringPresentation = false
        self.searchBar.placeholder = "Digite uma moeda..."
        self.searchBar.sizeToFit()
        self.searchBar.searchBarStyle = .prominent
        self.searchBar.delegate = self
        self.searchBar.scopeButtonTitles = buttonScopes
    }
    
}

extension SearchBarViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        delegateSearch?.textDidChangeSearchBar(searchBar.text ?? "Error", selectedScope)
    }
}


extension SearchBarViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.selectedScopeButtonIndex
        delegateSearch?.textDidChangeSearchController(searchBar.text ?? "Error", scope)
    }
}
