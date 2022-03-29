//
//  SearchView.swift
//  BTGChallenge
//
//  Created by Mateus Rodrigues on 25/03/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol SearchDelegate: AnyObject {
    func currencieSelectedClicked(_ cell: CurrencyCellView)
}

class SearchView: UIView {
    
    var viewModel: SearchViewModel
    weak var delegate: SearchDelegate?
    let disposeBag = DisposeBag()
    
    var characterTableView: UITableView!
    
    init(viewModel: SearchViewModel, frame: CGRect = .zero) {
        self.viewModel = viewModel
        characterTableView = UITableView()
        super.init(frame: frame)
        applyViewCode()
        setUpObservers()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    
    private func setUpObservers() {
        observerData()
        observerSelection()
    }
    
    private func observerData() {
        viewModel.listCurrencyRelay.bind(to: characterTableView.rx.items(cellIdentifier: "MyCell", cellType: CurrencyCellView.self)) { row, model, cell in
            cell.nameCurrency.text = "\(model.key) - \(model.value)"
            cell.acronym = model.key
            cell.name = model.value
        }
        .disposed(by: self.disposeBag)
    }
    
    
    private func observerSelection() {
        characterTableView.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] element in
            if let cell = self?.characterTableView.cellForRow(at: element) as? CurrencyCellView {
                self?.delegate?.currencieSelectedClicked(cell)
            }
        }).disposed(by: self.disposeBag)
    }
    
}

extension SearchView: ViewCodable {
    
    func buildHierarchy() {
        self.addSubview(characterTableView)
    }
    
    func setupConstraints() {
        characterTableView.snp.makeConstraints { make in
            make.top.equalTo(self.snp_topMargin).offset(20)
            make.bottom.equalTo(self.snp_bottomMargin)
            make.left.equalTo(self.snp_leftMargin)
            make.right.equalTo(self.snp_rightMargin)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        characterTableView.contentInsetAdjustmentBehavior = .never
        characterTableView.register(CurrencyCellView.self, forCellReuseIdentifier: "MyCell")
    }
}
