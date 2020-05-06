//
//  HomeView.swift
//  Screens
//
//  Created by Gustavo Amaral on 29/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import SnapKit
import Storage
import Models

class HomeView: UIView, Drawable {
    
    private(set) weak var otherCurrenciesTableView: UITableView!
    private weak var selectedCurrencyPair: Header.SelectedCurrencyPair!
    private weak var statusBarBackground: UIView!
    private weak var bottomBackground: UIView!
    weak var delegate: CurrencyPairDelegate?
    
    var quote: Header.SelectedCurrencyPair.Model?
    var otherCurrencies = [Cell.Model]() { didSet { otherCurrenciesTableView.reloadData() } }
    
    func makeConstraints() {
        otherCurrenciesTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
        }
        
        statusBarBackground.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(otherCurrenciesTableView.snp.top)
        }
        
        bottomBackground.snp.makeConstraints { make in
            make.top.equalTo(otherCurrenciesTableView.snp.bottom)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom)
        }
    }
    
    func stylizeViews() {
        backgroundColor = #colorLiteral(red: 0.2119999975, green: 0.2630000114, blue: 0.3330000043, alpha: 1)
        bottomBackground.backgroundColor = #colorLiteral(red: 0.2820000052, green: 0.3219999969, blue: 0.3840000033, alpha: 1)
        otherCurrenciesTableView.separatorStyle = .none
        otherCurrenciesTableView.showsVerticalScrollIndicator = false
        otherCurrenciesTableView.allowsSelection = false
        otherCurrenciesTableView.backgroundColor = #colorLiteral(red: 0.2119999975, green: 0.2630000114, blue: 0.3330000043, alpha: 1)
    }
    
    func createViewsHierarchy() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        otherCurrenciesTableView = tableView
        addSubview(tableView)
        
        let statusBarBackground = UIView()
        self.statusBarBackground = statusBarBackground
        addSubview(statusBarBackground)
        
        let bottomBackground = UIView()
        self.bottomBackground = bottomBackground
        addSubview(bottomBackground)
    }
}

extension HomeView: UITableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier)
        guard let header = item as? Header else {
            assertionFailure("The type of header must be Header")
            return nil
        }
        header.draw()
        header.quote = quote
        header.selectedCurrencyPair.delegate = delegate
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 283/734 * tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
}

extension HomeView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genericCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let cell = genericCell as? Cell else { fatalError("The type of cells must be Cell") }
        
        if cell.quote == nil {
            cell.draw()
        }
        
        cell.quote = otherCurrencies[indexPath.row]
        
        return cell
    }
    
    class Cell: UITableViewCell, Drawable {
        
        private weak var amount: UILabel!
        private weak var currenciesPair: UILabel!
        private weak var lastSeen: UILabel!
        private weak var bottomLine: UIView!
        
        var quote: Model? {
            didSet {
                amount.text = quote?.value
                currenciesPair.text = quote?.currenciesPair
                lastSeen.text = quote?.lastSeen
            }
        }
        
        func makeConstraints() {
            amount.snp.makeConstraints { make in
                make.leading.equalTo(snp.leading).inset(52)
                make.bottom.equalTo(snp.bottom).inset(12.5)
            }
            
            currenciesPair.snp.makeConstraints { make in
                make.lastBaseline.equalTo(amount.snp.lastBaseline)
                make.leading.equalTo(amount.snp.trailing).offset(8)

            }
            
            lastSeen.snp.makeConstraints { make in
                make.top.equalTo(snp.top).offset(21.5)
                make.trailing.equalTo(snp.trailing).inset(26)
            }
            
            bottomLine.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.leading.equalTo(snp.leading).offset(16)
                make.trailing.equalTo(snp.trailing).offset(16)
                make.bottom.equalTo(snp.bottom)
            }
        }
        
        func stylizeViews() {
            amount.font = .sfPro(.title1(.plain))
            amount.textColor = .white
            amount.alpha = 0.8
            
            currenciesPair.font = .sfPro(.title3(.plain))
            currenciesPair.textColor = .white
            currenciesPair.alpha = 0.8
            
            lastSeen.font = .sfPro(.subheadline(.plain))
            lastSeen.textColor = .white
            lastSeen.alpha = 0.8
            
            backgroundColor = #colorLiteral(red: 0.2820000052, green: 0.3219999969, blue: 0.3840000033, alpha: 1)
            bottomLine.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        }
        
        func createViewsHierarchy() {
            let amount = UILabel()
            self.amount = amount
            addSubview(amount)
            
            let currenciesPair = UILabel()
            self.currenciesPair = currenciesPair
            addSubview(currenciesPair)
            
            let lastSeen = UILabel()
            self.lastSeen = lastSeen
            addSubview(lastSeen)
            
            let bottomLine = UIView()
            self.bottomLine = bottomLine
            addSubview(bottomLine)
        }
        
        struct Model {
            let value: String
            let currenciesPair: String
            let lastSeen: String
        }
    }
    
    class Header: UITableViewHeaderFooterView, Drawable {
        
        private(set) weak var selectedCurrencyPair: SelectedCurrencyPair!
        private weak var footer: Footer!
        private weak var gridBackground: UIImageView!
        
        var quote: SelectedCurrencyPair.Model? {
            get { selectedCurrencyPair.quote }
            set { selectedCurrencyPair.quote = newValue }
        }
        
        func makeConstraints() {
            gridBackground.snp.makeConstraints { make in
                make.edges.equalTo(snp.edges)
            }
            
            selectedCurrencyPair.snp.makeConstraints { make in
                make.leading.equalTo(snp.leading)
                make.trailing.equalTo(snp.trailing)
                make.top.equalTo(safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(footer.snp.top)
            }
            
            footer.snp.makeConstraints { make in
                make.leading.equalTo(snp.leading)
                make.trailing.equalTo(snp.trailing)
                make.bottom.equalTo(snp.bottom)
            }
            
            selectedCurrencyPair.makeConstraints()
            footer.makeConstraints()
        }
        
        func createViewsHierarchy() {
            let gridBackground = UIImageView(image: #imageLiteral(resourceName: "GridBackground"))
            addSubview(gridBackground)
            self.gridBackground = gridBackground
            
            let selectedCurrencyPair = SelectedCurrencyPair()
            addSubview(selectedCurrencyPair)
            self.selectedCurrencyPair = selectedCurrencyPair
            
            let footer = Footer()
            addSubview(footer)
            self.footer = footer
            
            selectedCurrencyPair.createViewsHierarchy()
            footer.createViewsHierarchy()
        }
        
        func stylizeViews() {
            gridBackground.backgroundColor = #colorLiteral(red: 0.2119999975, green: 0.2630000114, blue: 0.3330000043, alpha: 1)
            selectedCurrencyPair.stylizeViews()
            footer.stylizeViews()
        }
        
        class SelectedCurrencyPair: UIView, Drawable {
            
            private weak var linearContainer: UIView!
            private weak var amount: UILabel!
            private(set) weak var firstCurrency: UILabel!
            private weak var firstCurrencyDashedLine: UIImageView!
            private weak var to: UILabel!
            private(set) weak var secondCurrency: UILabel!
            private weak var secondCurrencyDashedLine: UIImageView!
            private weak var lastUpdate: UILabel!
            weak var delegate: CurrencyPairDelegate?
            
            var quote: Model? {
                didSet {
                    amount.text = quote?.value
                    firstCurrency.text = quote?.firstCurrency
                    secondCurrency.text = quote?.secondCurrency
                    lastUpdate.text = quote?.lastUpdate
                }
            }
            
            func makeConstraints() {
                amount.snp.makeConstraints { make in
                    make.leading.equalTo(linearContainer.snp.leading)
                }
                
                firstCurrency.snp.makeConstraints { make in
                    make.leading.equalTo(amount.snp.trailing).offset(8)
                    make.lastBaseline.equalTo(amount.snp.lastBaseline)
                }
                
                firstCurrencyDashedLine.snp.makeConstraints { make in
                    make.width.equalTo(firstCurrency.snp.width)
                    make.top.equalTo(firstCurrency.snp.bottom)
                    make.height.equalTo(1)
                    make.centerX.equalTo(firstCurrency.snp.centerX)
                }
                
                to.snp.makeConstraints { make in
                    make.leading.equalTo(firstCurrency.snp.trailing).offset(4)
                    make.lastBaseline.equalTo(amount.snp.lastBaseline)
                }
                
                secondCurrency.snp.makeConstraints { make in
                    make.leading.equalTo(to.snp.trailing).offset(4)
                    make.lastBaseline.equalTo(amount.snp.lastBaseline)
                }
                
                secondCurrencyDashedLine.snp.makeConstraints { make in
                    make.width.equalTo(secondCurrency.snp.width)
                    make.top.equalTo(secondCurrency.snp.bottom)
                    make.height.equalTo(1)
                    make.centerX.equalTo(secondCurrency.snp.centerX)
                }
                
                linearContainer.snp.makeConstraints { make in
                    make.leading.equalTo(amount.snp.leading)
                    make.trailing.equalTo(secondCurrency.snp.trailing)
                    make.top.equalTo(amount.snp.topMargin)
                    make.bottom.equalTo(amount.snp.firstBaseline)
                    make.centerX.equalTo(snp.centerX)
                    make.centerY.equalTo(snp.centerY)
                }
                
                lastUpdate.snp.makeConstraints { make in
                    make.top.equalTo(firstCurrencyDashedLine.snp.bottom).offset(6.5)
                    make.centerX.equalTo(linearContainer.snp.centerX)
                }
            }
            
            func stylizeViews() {
                amount.font = .sfPro(.largeTitle(.plain))
                amount.textColor = .white
                
                firstCurrency.font = .sfPro(.title3(.plain))
                firstCurrency.textColor = .white
                
                to.font = .sfPro(.title3(.plain))
                to.textColor = .white
                
                secondCurrency.font = .sfPro(.title3(.plain))
                secondCurrency.textColor = .white
                
                lastUpdate.font = .sfPro(.subheadline(.italic))
                lastUpdate.textColor = .white
                lastUpdate.alpha = 0.6
            }
            
            func createViewsHierarchy() {
                let amount = UILabel()
                self.amount = amount
                
                let firstCurrency = UILabel()
                firstCurrency.isUserInteractionEnabled = true
                let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleFirstCurrencyTap(_:)))
                firstCurrency.addGestureRecognizer(tapGesture1)
                firstCurrency.accessibilityIdentifier = "firstCurrency"
                self.firstCurrency = firstCurrency
                
                let firstDashedLine = UIImageView(image: #imageLiteral(resourceName: "DashedLine"))
                firstCurrencyDashedLine = firstDashedLine
                addSubview(firstDashedLine)
                
                let to = UILabel()
                to.text = "to"
                self.to = to
                
                let secondCurrency = UILabel()
                secondCurrency.isUserInteractionEnabled = true
                let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(handleSecondCurrencyTap(_:)))
                secondCurrency.addGestureRecognizer(tapGesture2)
                secondCurrency.accessibilityIdentifier = "secondCurrency"
                self.secondCurrency = secondCurrency
                
                let secondDashedLine = UIImageView(image: #imageLiteral(resourceName: "DashedLine"))
                secondCurrencyDashedLine = secondDashedLine
                addSubview(secondDashedLine)
                
                let lastUpdate = UILabel()
                self.lastUpdate = lastUpdate
                addSubview(lastUpdate)
                
                let linearContainer = UIView()
                linearContainer.addSubviews(amount, firstCurrency, to, secondCurrency)
                self.linearContainer = linearContainer
                addSubview(linearContainer)
            }
            
            @objc private func handleFirstCurrencyTap(_ sender: UITapGestureRecognizer) {
                guard let first = firstCurrency.text else { return }
                delegate?.currencyPair(self, didTouch: .first(first))
            }
            
            @objc private func handleSecondCurrencyTap(_ sender: UITapGestureRecognizer) {
                guard let second = secondCurrency.text else { return }
                delegate?.currencyPair(self, didTouch: .second(second))
            }
            
            
            
            struct Model {
                let value: String
                let firstCurrency: String
                let secondCurrency: String
                let lastUpdate: String
            }
        }
        
        private class Footer: UIView, Drawable {
            
            private weak var otherCurrencies: UILabel!
            
            func makeConstraints() {
                otherCurrencies.snp.makeConstraints { make in
                    make.leading.equalTo(snp.leading).inset(16)
                    make.trailing.equalTo(snp.trailing).inset(16)
                    make.top.equalTo(snp.top).inset(22)
                    make.bottom.equalTo(snp.bottom).inset(9)
                }
            }
            
            func stylizeViews() {
                otherCurrencies.font = .sfPro(.body(.plain))
                otherCurrencies.textColor = .white
                otherCurrencies.alpha = 0.8
                
                backgroundColor = #colorLiteral(red: 0.2823529412, green: 0.3215686275, blue: 0.3843137255, alpha: 1)
                layer.shadowColor = #colorLiteral(red: 0.2823529412, green: 0.3215686275, blue: 0.3843137255, alpha: 1)
                layer.shadowOffset = .init(width: 0, height: 2)
                layer.shadowRadius = 9
            }
            
            func createViewsHierarchy() {
                let otherCurrencies = UILabel()
                otherCurrencies.text = "Other currencies"
                self.otherCurrencies = otherCurrencies
                addSubview(otherCurrencies)
            }
        }
    }
}

protocol CurrencyPairDelegate: AnyObject {
    func currencyPair(_ sender: HomeView.Header.SelectedCurrencyPair, didTouch currency: CurrencyPairElement)
}

fileprivate let headerIdentifier = "headerIdentifier"
fileprivate let cellIdentifier = "cellIdentifier"
