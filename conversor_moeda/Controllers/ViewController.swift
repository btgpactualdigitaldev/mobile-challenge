//
//  ViewController.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 26/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var child = SpinnerViewController()
    
    @IBOutlet weak var deButton: UIButton!
    @IBOutlet weak var paraButton: UIButton!
    @IBOutlet weak var valorTextField: UITextField!
    @IBOutlet weak var valorConvertidoTextField: UITextField!
    
    //Presenter
    var selecaoMoeda: SelecaoMoedaPresenterProtocol = SelecaoMoedaPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valorTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if SelectedMoedasConversaoSingleton.moeda1 == nil {
            deButton.setTitle( "Clique aqui", for: .normal)
        } else {
            deButton.setTitle(SelectedMoedasConversaoSingleton.moeda1, for: .normal)
        }
        
        if SelectedMoedasConversaoSingleton.moeda2 == nil {
            paraButton.setTitle( "Clique aqui", for: .normal)
        } else {
            paraButton.setTitle(SelectedMoedasConversaoSingleton.moeda2, for: .normal)
        }
    }

    @IBAction func selectDeButtonClick(_ sender: UIButton) {
        SelectedMoedasConversaoSingleton.selectMoeda = .deMoeda
    }
    
    @IBAction func selectParaButtonClick(_ sender: UIButton) {
        SelectedMoedasConversaoSingleton.selectMoeda = .paraMoeda
    }
    
    @IBAction func converterButtonClick(_ sender: UIButton) {
        createSpinnerView()
        if  SelectedMoedasConversaoSingleton.moeda2 == nil ||
            SelectedMoedasConversaoSingleton.moeda1 == nil ||
            self.valorTextField.text == ""
        {
                removeSpinnerView()
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Erro", message: "Algum dos campos não foi preenchido.", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                    self.present(alert, animated: true)
                }
            
                return
            
        }
        var valorText = valorTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        valorText = valorText.replacingOccurrences(of: ".", with: "")
        valorText = valorText.replacingOccurrences(of: ",", with: ".")
        
        selecaoMoeda.carregarDadosDeMoedasCotacao(deMoeda: SelectedMoedasConversaoSingleton.moeda1,
                                                  paraMoeda: SelectedMoedasConversaoSingleton.moeda2,
                                                  valor: Double(valorText))
        { [weak self] (result, error) -> Void in
            self!.removeSpinnerView()
            if error == .noError {
                //self!.removeSpinnerView()
                DispatchQueue.main.async {
                    self!.valorConvertidoTextField.text = String(format: "%.2f",result!).currencyInputFormatting()
                }
            } else {
                self!.removeSpinnerView()
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Falha na comunicação", message: "vamos tentar novamente?", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Sim", style: .default, handler:
                        { action in
                            self!.converterButtonClick(sender)
                        }))

                    self!.present(alert, animated: true)
                }
            }
        }
        
    }
    
}



extension ViewController
{
   func createSpinnerView() {

        DispatchQueue.main.async {
            self.child = SpinnerViewController()
            // add the spinner view controller
            self.addChild(self.child)
            self.child.view.frame = self.view.frame
            self.view.addSubview(self.child.view)
            self.child.didMove(toParent: self)
        }
        
        
    }
    
    func removeSpinnerView(){
        // wait two seconds to simulate some work happening
        DispatchQueue.main.async {
            // then remove the spinner view controller
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }
}


