//
//  SelectCurrencyController.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 23/11/20.
//

import SnapKit
import Combine

protocol SelectCurrencyViewControllerDelegate {
    func didSelect(source: String, iten: Int)
    func didCancel()
}

class SelectCurrencyViewController: UIViewController {
    let selectCurrencyViewModelController = SelectCurrencyViewModelController()

    var delegate: SelectCurrencyViewControllerDelegate!
    
    var itenCoin: Int!
    
    fileprivate var dataCoins = [SelectCurrencyViewModel]()
    fileprivate var sourceSelect: String?
    
    lazy var homeActionsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.viewCornerRadius = 10.0
        return view
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Selecionar", for: .normal)
        button.setTitleColor(Constant.colorBtg, for: .normal)
        button.addTarget(self, action: #selector(self.didSelect), for: .touchUpInside)

        return button
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(Constant.colorBtg, for: .normal)
        button.addTarget(self, action: #selector(self.didCancel), for: .touchUpInside)

        return button
    }()

    let coinsTableView : UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        return tableview
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 1.0, delay: 0.5, animations: {
            self.view.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        })
        self.sourceSelect = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.view.backgroundColor = .clear
        self.sourceSelect = nil
        self.coinsTableView.reloadData()
    }
}

extension SelectCurrencyViewController {

    @objc
    fileprivate func didSelect() {
        self.delegate?.didSelect(source: self.sourceSelect ?? "", iten: itenCoin)
    }

    @objc
    fileprivate func didCancel() {
        self.delegate?.didCancel()
    }
}

//MARK: Default protocol from ViewController
extension SelectCurrencyViewController: DefaultView {
    func buildView() {
        self.view.backgroundColor = .clear
        self.view.addSubview(homeActionsView)
        
        self.homeActionsView.addSubview(cancelButton)
        self.homeActionsView.addSubview(doneButton)
        self.homeActionsView.addSubview(coinsTableView)
        
    }
    
    func setupConstraints() {
        homeActionsView.snp.makeConstraints { make in
            make.top.equalTo(UIScreen.main.bounds.height / 2)
            make.left.right.bottom.equalToSuperview()
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10.0)
            make.left.equalToSuperview().inset(20.0)
        }

        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10.0)
            make.right.equalToSuperview().inset(20.0)
        }
        
        coinsTableView.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(20.0)
            make.right.left.bottom.equalToSuperview().inset(10.0)
        }

    }
    
    func setupAditionalConfigurations() {
        self.view.backgroundColor = .clear
        
        self.coinsTableView.dataSource = self
        self.coinsTableView.delegate = self
        self.coinsTableView.register(CoinCell.self, forCellReuseIdentifier: "coinCell")

        selectCurrencyViewModelController.retrieveCoins({ [unowned self] in
            self.dataCoins = selectCurrencyViewModelController.Coins()
            DispatchQueue.main.async {
                self.coinsTableView.reloadData()
            }
        }, failure: nil)

    }
}

extension SelectCurrencyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath) as! CoinCell
        cell.delegate = self
        cell.selectionStyle = .none
        cell.data = dataCoins[indexPath.row]
        
        if(sourceSelect == cell.data?.source){
            cell.icon.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SelectCurrencyViewController: CoinCellDelegate{
    func didUnselect(source: String) {
        self.sourceSelect = source
        self.coinsTableView.reloadData()
    }
}
