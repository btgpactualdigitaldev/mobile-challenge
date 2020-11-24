//
//  ListCoinViewController.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 24/11/20.
//
import SnapKit

class ListCoinViewController: UIViewController {
    let selectCurrencyViewModelController = SelectCurrencyViewModelController()
    let erroView = ErrorViewController()
    
    fileprivate var dataCoins = [SelectCurrencyViewModel]()

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
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


//MARK: Default protocol from ViewController
extension ListCoinViewController: DefaultView {
    func buildView() {
        self.view.backgroundColor = .clear
        self.view.addSubview(coinsTableView)
    }
    
    func setupConstraints() {
        coinsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.0)
            make.right.left.bottom.equalToSuperview().inset(10.0)
        }
    }
    
    func setupAditionalConfigurations() {
        self.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constant.textCoinList
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : Constant.colorBtg]
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = Constant.colorBtg
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "SF_xmark_square_fill")?.resize(toHeight: 20.0),
            style: .plain,
            target: self,
            action: #selector(didBack)
        )
        
        self.coinsTableView.dataSource = self
        self.coinsTableView.delegate = self
        self.coinsTableView.register(CoinCell.self, forCellReuseIdentifier: "coinCell")

        selectCurrencyViewModelController.retrieveCoins({ [unowned self] in
            self.dataCoins = selectCurrencyViewModelController.Coins()
            DispatchQueue.main.async {
                self.coinsTableView.reloadData()
            }
        }, failure: {
            self.erro()
        }
        )
    }
    
    func erro() {
        DispatchQueue.main.async {

            self.erroView.delegate = self
            self.erroView.modalPresentationStyle = .custom
            self.present(self.erroView, animated: true)
        }
    }
    @objc
    fileprivate func didBack() {
        navigationController?.popViewController(animated: true)
    }

}
extension ListCoinViewController: ErrorViewControllerDelegate {
    func didClose() {
        erroView.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}


extension ListCoinViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath) as! CoinCell
        cell.selectionStyle = .none
        cell.data = dataCoins[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

