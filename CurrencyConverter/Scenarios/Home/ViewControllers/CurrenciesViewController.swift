//
//  CurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol CurrenciesViewControllerDelegate: AnyObject {
    func userDidRequestConvert(fromCurrency: CurrencyModel, toCurrency: CurrencyModel)
}

final class CurrenciesViewController: UIViewController, CurrenciesStoryboardLodable {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var fromLabel: UILabel!
    @IBOutlet private weak var toLabel: UILabel!
    @IBOutlet private weak var sortButton: UIButton!
    @IBOutlet private weak var tryAgainLabel: UILabel!
    @IBOutlet private weak var tryAgainButton: UIButton!

    // MARK: - Properties

    var viewModel: CurrenciesViewModel!
    var delegate: CurrenciesViewControllerDelegate?

    // MARK: - Fields

    private var disposeBag = DisposeBag()
    private let doneButton: UIBarButtonItem
    private let searchController: UISearchController
    private let cleanButton: UIBarButtonItem

    required init?(coder aDecoder: NSCoder) {
        searchController = UISearchController(searchResultsController: nil)
        doneButton = UIBarButtonItem(title: "Converter", style: .plain, target: nil, action: nil)
        cleanButton = UIBarButtonItem(title: "Limpar", style: .plain, target: nil, action: nil)

        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBinding()
        setupData()
    }

    // MARK: - Setup

    private func setupUI() {
        //Header Elements
        title = "Selecionar Moedas"
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cleanButton
        
        //TableView
        tableView.estimatedRowHeight = 0
        tableView.rowHeight = 80
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        //Search Controller
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupBinding() {
        //TableView
        tableView.rx
            .modelSelected(CurrencyModel.self).bind { [weak self] currency in
                if let same = self?.viewModel.sameCurrency(toCurrency: currency), same {
                    self?.alert(message: "Selecione uma moeda diferente da primeira selecionada \"De\"")
                } else if let set = self?.viewModel.tapCurrency(currency), !set {
                    self?.alert(message: "Moedas já selecionadas! Caso queira trocar, clique em \"Limpar\"")
                }
            }.disposed(by: disposeBag)
        tableView.rx
            .itemSelected.bind { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }.disposed(by: disposeBag)
        
        //IndicatorView
        viewModel.isLoading.observeOn(MainScheduler.instance).bind(to: indicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        //Botão de ordenação
        sortButton.rx.tap.bind { [weak self] in
            self?.viewModel.tapSortButton()
            if let az = self?.viewModel.sortAZ.value {
                self?.sortButton.setTitle(az ? "Ordenar (A-Z)" : "Ordenar (Z-A)", for: .normal)
            }
        }.disposed(by: disposeBag)
        
        //Botão que finaliza a escolha das moedas (caso estiver tudo certo) e chama a tela de conversão
        doneButton.rx.tap.bind { [weak self] in
            if let fromCurrency = self?.viewModel.fromCurrency.value, let toCurrency = self?.viewModel.toCurrency.value {
                if let delegate = self?.delegate {
                    delegate.userDidRequestConvert(fromCurrency: fromCurrency, toCurrency: toCurrency)
                }
            }
        }.disposed(by: disposeBag)
        viewModel.converterEnabled.observeOn(MainScheduler.instance).bind(to: doneButton.rx.isEnabled).disposed(by: disposeBag)
        
        //Botão que limpa as moedas selecionadas
        cleanButton.rx.tap.bind { [weak self] in
            self?.viewModel.tapClean()
        }.disposed(by: disposeBag)
        viewModel.cleanEnabled.observeOn(MainScheduler.instance).bind(to: cleanButton.rx.isEnabled).disposed(by: disposeBag)
        
        //Labels das moedas selecionadas
        viewModel.fromText.observeOn(MainScheduler.instance).bind(to: fromLabel.rx.text).disposed(by: disposeBag)
        viewModel.toText.observeOn(MainScheduler.instance).bind(to: toLabel.rx.text).disposed(by: disposeBag)
        
        //Botão e label de tentar novamente
        viewModel.tryAgainTextHidden.observeOn(MainScheduler.instance).bind(to: tryAgainLabel.rx.isHidden).disposed(by: disposeBag)
        viewModel.tryAgainButtonHidden.observeOn(MainScheduler.instance).bind(to: tryAgainButton.rx.isHidden).disposed(by: disposeBag)
        tryAgainButton.rx.tap.bind { [weak self] in
            self?.viewModel.tapTryAgain()
        }.disposed(by: disposeBag)
        
        //Search Controller
        searchController.searchBar[keyPath: \.searchTextField].placeholder = "Digite a sigla ou o nome da moeda"
        searchController.searchBar[keyPath: \.searchTextField].font = UIFont(name: "Helvetica", size: 15)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
        
        searchController.searchBar.rx.text.throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance).bind(to: viewModel.filter).disposed(by: disposeBag)
        searchController.searchBar.rx.textDidBeginEditing.bind { [weak self] in self?.searchController.searchBar.setShowsCancelButton(true, animated: true) }.disposed(by: disposeBag)
        
        searchController.searchBar.rx.cancelButtonClicked.bind { [weak self] in
            self?.searchController.searchBar.resignFirstResponder()
            self?.searchController.searchBar.setShowsCancelButton(false, animated: true)
            self?.viewModel.filter.accept("")
            self?.searchController.searchBar.text = ""
        }.disposed(by: disposeBag)
    }

    private func setupData() {
        tableView.register(cellType: CurrencyCell.self)

        viewModel.currencies
            .bind(to: tableView.rx.items(cellIdentifier: CurrencyCell.reuseIdentifier, cellType: CurrencyCell.self)) { _, element, cell in
                cell.model = element
            }.disposed(by: disposeBag)
    }
}
