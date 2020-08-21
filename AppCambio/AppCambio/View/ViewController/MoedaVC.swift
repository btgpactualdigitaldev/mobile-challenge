//
//  MoedaVC.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import UIKit

protocol MoedaViewDelegate {
    func moedaSelecionada(_ moeda: Moeda)
}

class MoedaVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: @IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Properties
    
    var delegate: MoedaViewDelegate?
    var moedaSelecionada: Moeda?
    private var moedas: [Moeda] = []
    private var presenter: MoedaViewToPresenter = MoedaPresenter()
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getData()
    }
    
    
    // MARK: Methods
    
    private func setup() {
        presenter.view = self
        startLoading("Carregando moedas, aguarde...")
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moedas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let moeda = moedas[indexPath.row]
        cell.textLabel?.text = moeda.descricao
        cell.accessoryType = .none
        cell.accessoryType = moedaSelecionada == moeda ? .checkmark : .none
        return cell
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.moedaSelecionada(moedas[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.search(searchText)
    }
}

extension MoedaVC: MoedaPresenterToView {
    
    func returnData(_ moedas: [Moeda]) {
        if moedas.isEmpty {
            Helper.alertController("Atenção", message: "Não foram encotradas moedas.")
        }
        self.moedas = moedas.sorted(by: {$0.descricao < $1.descricao})
        tableView.reloadData()
        stopLoading()
    }
}
