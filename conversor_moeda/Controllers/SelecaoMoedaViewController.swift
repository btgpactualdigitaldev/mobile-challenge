//
//  SelecaoMoedaViewController.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 26/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import UIKit

class SelecaoMoedaViewController: UIViewController {
    
    var child = SpinnerViewController()
    
    @IBOutlet weak var tableview: UITableView!
    var selecaoMoedaList: [SelecaoMoedaViewModel] = []
    
    //Presenter
    var selecaoMoeda: SelecaoMoedaPresenterProtocol = SelecaoMoedaPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initializer() {
        createSpinnerView()
        selecaoMoeda.carregarDadosDeMoedas() { [weak self] (result, error) -> Void in
            if error == .noError {
                self!.selecaoMoedaList = result
                
                self!.removeSpinnerView()
                DispatchQueue.main.async {
                    self?.tableview.reloadData()
                }
            } else {
                self!.removeSpinnerView()
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Falha na comunicação", message: "vamos tentar novamente?", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Sim", style: .default, handler:
                        { action in
                            self!.initializer()
                        }))

                    self!.present(alert, animated: true)
                }
            }
        }
    }
}

extension SelecaoMoedaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selecaoMoedaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MoedasTableViewCell
        cell.moedaLabel.text = selecaoMoedaList[indexPath.row].moeda
        cell.siglaLabel.text = selecaoMoedaList[indexPath.row].sigla
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if SelectedMoedasConversaoSingleton.selectMoeda == selectMoeda.deMoeda {
            SelectedMoedasConversaoSingleton.moeda1 = selecaoMoedaList[indexPath.row].sigla
        } else if SelectedMoedasConversaoSingleton.selectMoeda == selectMoeda.paraMoeda{
            SelectedMoedasConversaoSingleton.moeda2 = selecaoMoedaList[indexPath.row].sigla
        }
        
        navigationController?.popViewController(animated: false)
    }
    
}


extension SelecaoMoedaViewController 
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
