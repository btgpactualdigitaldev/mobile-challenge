//
//  ListVC.swift
//  MobileChallenge
//
//  Created by Vitor Gomes on 07/09/21.
//

import UIKit

class ListVC: UIViewController {
    
    private var listTitle = UILabel()
    private var listTableView = UITableView()
    
    var viewModel = ListViewModel()
    
    var initials: [String] = []
    var fullnames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        self.listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
    }

}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = initials.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell else {return UITableViewCell()}
        cell.onBindViewHolder(initial: initials[indexPath.row],
                              fullName: fullnames[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}


// MARK: - Layout

extension ListVC {
    func setupLayout() {
        
        view.backgroundColor = Colors.primary
        
        view.addSubview(listTitle)
        listTitle.translatesAutoresizingMaskIntoConstraints = false
        listTitle.text = "Availables Currencies"
        listTitle.textAlignment = .center
        listTitle.textColor = .white
        NSLayoutConstraint.activate([
            listTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            listTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
 
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: listTitle.bottomAnchor, constant: 32),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
}
