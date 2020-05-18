//
//  CoinListViewModel.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

protocol CoinListViewModelDataStore {
    var selectedCoin: String? { get set }
    var cellViewModels: [CoinListCellViewModel] { get set }
}

protocol CoinListViewModelInput: ViewModelInput {
    func searchForCoin(string: String)
}

protocol CoinListViewModelOutput: ViewModelOutput {
    func displayCoinList(viewModel: CoinListTableViewModel)
    func displayListError(message: String)
}

final class CoinListViewModel: CoinListViewModelDataStore {
        
    // MARK: - Properties
    
    var selectedCoin: String?
    var cellViewModels = [CoinListCellViewModel]()
    
    fileprivate let repository: CurrencyRepository
    weak var viewController: CoinListViewModelOutput?
    
    init(repository: CurrencyRepository) {
        self.repository = repository
    }
    
}

// MARK: - Inputs
extension CoinListViewModel: CoinListViewModelInput {
    func viewDidLoad() {
        viewController?.displayLoadingView()
        
        repository.list { [weak self] (listResult) in
            self?.viewController?.hideLoadingView()
            
            switch listResult {
            case .success(let listResponse):
                self?.displayCoinList(listResponse: listResponse)
            case .failure(let error):
                self?.displayListError(message: Constants.Errors.apiDefaultMessage)
            }
        }
    }
    
    func searchForCoin(string: String) {
        let lowercasedString = string.lowercased()
        let filteredCellViewModels = string.isEmpty ?
            cellViewModels :
            cellViewModels
                .filter({
                    $0.shortCoinName.lowercased().contains(lowercasedString) ||
                    $0.fullCoinName.lowercased().contains(lowercasedString)
                })
        
        displayFilteredCoinList(filteredCellViewModels: filteredCellViewModels)
    }
}

// MARK: - Outputs
extension CoinListViewModel {
    func displayCoinList(listResponse: ListResponse) {
        let viewModel = CoinListTableViewModel()
        viewModel.selectedCoin = selectedCoin ?? ""
        
        cellViewModels = listResponse
            .currencies?
            .coinStrategy
            .compactMap { element in
                guard let value = element.value else {
                    return nil
                }
                
                let cellViewModel = CoinListCellViewModel()
                cellViewModel.shortCoinName = element.key
                cellViewModel.fullCoinName = value
                
                return cellViewModel
            }
            .sorted(by: { $0.shortCoinName < $1.shortCoinName }) ?? []
        
        viewModel.cellViewModels = cellViewModels
        
        viewController?.displayCoinList(viewModel: viewModel)
    }
    
    func displayListError(message: String) {
        viewController?.displayListError(message: message)
    }
    
    func displayFilteredCoinList(filteredCellViewModels: [CoinListCellViewModel]) {
        let viewModel = CoinListTableViewModel()
        viewModel.selectedCoin = selectedCoin ?? ""
        viewModel.cellViewModels = filteredCellViewModels
        
        viewController?.displayCoinList(viewModel: viewModel)
    }
}
