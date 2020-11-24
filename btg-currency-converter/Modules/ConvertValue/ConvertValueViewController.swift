//
//  ConvertValueController.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 20/11/20.
//
import SnapKit

class ConvertValueViewController: UIViewController {
    let erroView = ErrorViewController()
    let selectCurrenctView = SelectCurrencyViewController()
    let convertValueViewModelController = ConvertValueViewModelController()
    var originValue: Double?
    var destinyValue: Double?
    
    lazy var coinSourceButton: ButtonBtg = {
        let button = ButtonBtg()
        button.titleLabel.text = Constant.textConverter
        button.iconImageView.image = UIImage(named: "Ion_ios_swap")
        button.buttonAction.addTarget(self, action: #selector(self.didSelectSource), for: .touchUpInside)
        return button
    }()
    
    lazy var iconToImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SF_arrow_right_square")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var coinDestinyButton: ButtonBtg = {
        let button = ButtonBtg()
        button.titleLabel.text = Constant.textConverter
        button.iconImageView.image = UIImage(named: "Ion_ios_swap")
        button.buttonAction.addTarget(self, action: #selector(self.didSelectDestiny), for: .touchUpInside)
        return button
    }()
    
    lazy var convertValueText: BtgTextField = {
        let text = BtgTextField()
        text.lineHeight = 0.0
        text.selectedLineHeight = 0.0
        text.imputType = .normal
        text.font = .boldSystemFont(ofSize: 25.0)
        text.textAlignment = .center
        text.clearButtonMode = .whileEditing
        text.tag = 1
        text.placeholder = "Insira o valor"
        text.title = "Valor à converter"
        text.requiredMessage = "Informe o valor para conversão"
        text.imputMask = .money
        text.returnKeyType = .done
        text.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        return text
    }()
    
    lazy var valueConverterLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25.0)
        label.textAlignment = .center
        label.text = "0,00"
        label.textColor = Constant.colorBtg
        return label
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

extension ConvertValueViewController {
    
    func showSelectCurrency(itenCoin: Int) {
        selectCurrenctView.modalPresentationStyle = .custom
        selectCurrenctView.itenCoin = itenCoin
        selectCurrenctView.delegate = self
        present(selectCurrenctView, animated: true)
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

    @objc
    fileprivate func didSelectSource() {
        showSelectCurrency(itenCoin: 1)
    }
    
    @objc
    fileprivate func didSelectDestiny() {
        showSelectCurrency(itenCoin: 2)
    }
    @objc
    func didChange(_ textField: UITextField) {
        convert()
    }
}

extension ConvertValueViewController: ErrorViewControllerDelegate {
    func didClose() {
        erroView.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}

extension ConvertValueViewController : SelectCurrencyViewControllerDelegate {
    func didSelect(source: String, iten: Int) {
        if(iten==1){
            coinSourceButton.titleLabel.text = source
            selectCurrenctView.dismiss(animated: true, completion: nil)
            convertValueViewModelController.coin = source
            convertValueViewModelController.retrieveRate({ [unowned self] in
                self.originValue = self.convertValueViewModelController.rate.quotes?["USD" + source]
                convert()

            }, failure: nil)
        }
        else if(iten==2){
            coinDestinyButton.titleLabel.text = source
            selectCurrenctView.dismiss(animated: true, completion: nil)
            convertValueViewModelController.coin = source
            convertValueViewModelController.retrieveRate({ [unowned self] in
                self.destinyValue = self.convertValueViewModelController.rate.quotes?["USD" + source]
                convert()
                
            }, failure: {
                self.erro()
            })
        }
        
    }
    
    func didCancel() {
        selectCurrenctView.dismiss(animated: true, completion: nil)
    }
    
    func convert() {
        DispatchQueue.main.async {
            guard !self.convertValueText.text!.isEmpty && (self.destinyValue != nil) && (self.originValue != nil) else { return }
            
            let valueInput = Double(self.convertValueText.text!.replacingOccurrences(of: ".",
                                                                         with: "").replacingOccurrences(of: ",", with: ".")) ?? 0.0
            var result = valueInput * (self.destinyValue ?? 0)
            result = result / (self.originValue ?? 0)
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 5
            formatter.minimumFractionDigits = 5
            formatter.locale = Locale(identifier: "pt_BR")

            self.valueConverterLabel.text = formatter.string(from: NSNumber(value: result))!
        }
    }
}


//MARK: Default protocol from ViewController
extension ConvertValueViewController: DefaultView {
    func buildView() {
        self.view.addSubview(coinSourceButton)
        self.view.addSubview(iconToImageView)
        self.view.addSubview(coinDestinyButton)
        self.view.addSubview(convertValueText)
        self.view.addSubview(valueConverterLabel)
    }
    
    func setupConstraints() {
        convertValueText.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200.0)
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(40.0)
        }

        iconToImageView.snp.makeConstraints { make in
            make.top.equalTo(convertValueText.snp.bottom).offset(70.0)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(30.0)
        }
        coinSourceButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40.0)
            make.width.height.equalTo(100.0)
            make.centerY.equalTo(iconToImageView.snp.centerY)
        }
        coinDestinyButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(40.0)
            make.width.height.equalTo(100.0)
            make.centerY.equalTo(iconToImageView.snp.centerY)
        }
        valueConverterLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(40.0)
            make.top.equalTo(coinDestinyButton.snp.bottom).offset(30.0)
        }

       
    }
    
    func setupAditionalConfigurations() {
        self.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constant.textConverter
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
    }
}

