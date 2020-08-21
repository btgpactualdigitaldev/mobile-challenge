//
//  CambioVC.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import UIKit

class CambioVC: UIViewController, MoedaViewDelegate, UITextFieldDelegate {
    
    // MARK: @IBOutlets
    
    @IBOutlet weak var lblMoedaOrigem: UILabel!
    @IBOutlet weak var lblMoedaDestino: UILabel!
    @IBOutlet weak var txfMoedaOrigem: UITextField!
    @IBOutlet weak var txfMoedaDestino: UITextField!
    
    
    // MARK: Properties
    
    private var presenter: CambioViewToPresenter = CambioPresenter()
    private var moedaOrigem: Moeda?
    private var moedaDestino: Moeda?
    private var tipo: Int = 0
    
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    // MARK: Methods
    
    private func setup() {
        presenter.view = self
        txfMoedaOrigem.keyboardType = .numbersAndPunctuation
        txfMoedaDestino.keyboardType = .numbersAndPunctuation
    }
    
    private func setupLabels() {
        if let moedaOrigem = self.moedaOrigem {
            lblMoedaOrigem.text = "\(moedaOrigem.descricao):"
        }
        
        if let moedaDestino = self.moedaDestino {
            lblMoedaDestino.text = "\(moedaDestino.descricao):"
        }
    }
    
    private func validateInputs() -> Bool {
        guard moedaOrigem != nil else {
            Helper.alertController("Atenção", message: "Selecione a moeda de origem.")
            return false
        }
        
        guard moedaDestino != nil else {
            Helper.alertController("Atenção", message: "Selecione a moeda de destino.")
            return false
        }
        
        return true
    }
    
    private func calcularCambio() {
        guard let valor = Double(txfMoedaOrigem.text!) else {
            txfMoedaDestino.text = ""
            return
        }
        
        presenter.calculate(moedaOrigem!.identificador, to: moedaDestino!.identificador, value: valor)
    }
    
    
    
    // MARK: @IBActions
    
    @IBAction func btnTrocarOrigemClicked(_ sender: UIButton) {
        self.tipo = 1
        performSegue(withIdentifier: "presentToMoedaVC", sender: moedaOrigem)
    }
    
    @IBAction func btnTrocarDestinoClicked(_ sender: UIButton) {
        self.tipo = 2
        performSegue(withIdentifier: "presentToMoedaVC", sender: moedaDestino)
    }
    
    @IBAction func txfOrigemDidChanged(_ sender: UITextField) {
        calcularCambio()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let moedaVC = segue.destination as? MoedaVC {
            moedaVC.moedaSelecionada = sender as? Moeda
            moedaVC.delegate = self
        }
    }
    
    
    // MARK: MoedaViewDelegate
    
    func moedaSelecionada(_ moeda: Moeda) {
        tipo == 1 ? self.moedaOrigem = moeda : (self.moedaDestino = moeda)
        setupLabels()
        if let moedaOrigem = self.moedaOrigem, let moedaDestino = self.moedaDestino {
            if Reachability.isConnectedToNetwork() {
                presenter.getQuotes(moedaOrigem.identificador, to: moedaDestino.identificador)
            }
            if validateInputs() {
                calcularCambio()
            }
        }
    }
    
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if validateInputs() {
            switch string {
            case "","0","1","2","3","4","5","6","7","8","9":
                return true
            default:
                return false
            }
        }
        return false
    }
}

extension CambioVC: CambioPresenterToView {
    
    func returnValue(_ value: Double) {
        txfMoedaDestino.text = value.casasDecimais(2)
    }
}

