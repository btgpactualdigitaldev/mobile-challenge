//
//  ConvertViewController.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 13/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol ConvertViewControllerDelegate: AnyObject {
    //Fluxos a partir dessa tela
}

final class ConvertViewController: UIViewController, CurrenciesStoryboardLodable {
    
    // MARK: - Outlets

    @IBOutlet private weak var fromLabel: UILabel!
    @IBOutlet private weak var toLabel: UILabel!
    @IBOutlet private weak var convertedLabel: UILabel!
    @IBOutlet private weak var inputValueTextField: UITextField!
    
    // MARK: - Properties

    var viewModel: ConvertViewModel!
    weak var delegate: ConvertViewControllerDelegate?
    
    // MARK: - Fields

    private var disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
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
    }

    private func setupBinding() {
        //Labels
        viewModel.fromText.observeOn(MainScheduler.instance).bind(to: fromLabel.rx.text).disposed(by: disposeBag)
        viewModel.toText.observeOn(MainScheduler.instance).bind(to: toLabel.rx.text).disposed(by: disposeBag)
        viewModel.convertedText.observeOn(MainScheduler.instance).bind(to: convertedLabel.rx.text).disposed(by: disposeBag)
        inputValueTextField.rx.controlEvent(.editingChanged).asObservable().subscribe(onNext: { [weak self] in
            if let text = self?.inputValueTextField.text {
                let textFormatted = text.tryFormattingToCalculation()
                self?.inputValueTextField.text = textFormatted
                self?.viewModel.changeText.accept(textFormatted)
            }
        }).disposed(by: disposeBag)
    }

    private func setupData() {
    }
}
