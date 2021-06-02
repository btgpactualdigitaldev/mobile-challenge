//
//  ViewController.swift
//  conversorDeMoeda
//
//  Created by Diogenes de Souza on 07/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    let formatter = NumberFormatter()
        
    var cambioValorList: Dictionary<String,Double> = [:]
    var textOrig:String?
    var textDest:String?
    var siglaOrig:String?
    var siglaDest:String?
    
    @IBOutlet weak var origButton: UIButton!
    @IBOutlet weak var destButton: UIButton!
    @IBOutlet weak var display: UITextField!
    @IBOutlet weak var labelResult: UILabel!
    
    // MARK: fechar teclado ao tocar na view
    @IBAction func closeKeyboard(_ sender: Any) {
        labelResult.text = getValorDolar(textOrig: siglaOrig!, textDest: siglaDest!, valor: display.text!)
        self.view.endEditing(true)
    }
    // MARK: ação do primeiro botão
    @IBAction func actionOrig(_ sender: UIButton) {
        performSegue(withIdentifier: "next", sender: nil)
        UserDefaults.standard.set(1 , forKey: "buttonSelect")//salva 1 para o botão selecionado em UserDefault
    }
    // MARK: ação do segundo botão
    @IBAction func actionDest(_ sender: UIButton) {
        performSegue(withIdentifier: "next", sender: nil)
        UserDefaults.standard.set(2 , forKey: "buttonSelect")//salva 2 para o botão selecionado em UserDefault
    }
    // MARK: Atualiza o resultado ao digitar no campo de texto
    @IBAction func updateResult(_ sender: Any) {
        
        if !siglaOrig!.isEmpty &&  !siglaDest!.isEmpty{
            labelResult.text = getValorDolar(textOrig: siglaOrig!, textDest: siglaDest!, valor: display.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Recupera os dados  do valor e resultado
        if let value = UserDefaults.standard.string(forKey: "display"){
            display.text = value
            }
        if let value = UserDefaults.standard.string(forKey: "result"){
            labelResult.text = value
            }
        
        formatter.numberStyle = .currency
        formatter.alwaysShowsDecimalSeparator = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: recupera dados salvos
        self.textOrig =  UserDefaults.standard.string(forKey: "nomeOrig") ?? "Moeda de Origem"
        self.textDest =  UserDefaults.standard.string(forKey: "nomeDest") ?? "Moeda de destino"
        
        if let origSigla = UserDefaults.standard.string(forKey: "siglaOrig"){
            self.siglaOrig  =  origSigla
        }else{
            self.siglaOrig  =  ""
        }
        
        if let destSigla = UserDefaults.standard.string(forKey: "siglaDest"){
            self.siglaDest  =  destSigla
        }else{
            self.siglaDest  =  ""
        }
        
        origButton.setTitle(textOrig, for: .normal)
        destButton.setTitle(textDest, for: .normal)
        
        // MARK: Pega a lista de moedas com suas cotações no servidor
        Rest.loadCurrencys(endPoint: "live") { (nomesSiglas, siglasValues) in
            self.cambioValorList = siglasValues!
        } onError: { (cambioError) in
            print(cambioError)
        }
        // MARK: EXIBE RESULTADO SOMENTE SE O VALOR ESTIVERER PREENCHIDO E AS MOEDAS ESCOLHIDAS
        if !cambioValorList.isEmpty && !siglaOrig!.isEmpty && !siglaDest!.isEmpty {
            labelResult.text = getValorDolar(textOrig: siglaOrig!, textDest: siglaDest!, valor: display.text!)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // MARK: salvar dados no banco UserDefault, persistencia de dados do app
                UserDefaults.standard.set(display.text, forKey: "display")
        UserDefaults.standard.set(labelResult.text, forKey: "result")
    }
    
    
    func getValorFormatado(valor: Double, moedaCode: String) -> String{
        
        formatter.currencySymbol = moedaCode
        formatter.currencyCode = moedaCode
        return formatter.string(for: valor) ?? ""
    }
    
    // MARK: faz a conversão da moeda
    func getValorDolar(textOrig:String, textDest:String, valor:String) -> String{
        
        let valorNovo = valor.replacingOccurrences(of: ",", with: ".")
        
        var resultado:Double = 0
        let cotacao1:Double = cambioValorList["USD" + textOrig] ?? 1
        let cotacao2:Double = cambioValorList["USD" + textDest] ?? 1
        
        print("valor em cotaçao 1:\(cotacao1)")
        print("valor em cotacao 2:\(cotacao2)")
        
        // MARK: fórmula da conversão :  x= (valor digitado / indice1) * ídice2
        if let valordigitado = Double(valorNovo){
            print("Converteu valor digitado:\(valordigitado)")
            
            let valorEmDolar = valordigitado/cotacao1
            print("valor em dolar: \(valorEmDolar)")
            resultado = valorEmDolar * cotacao2
            print("valor em Destino: \(resultado)")
            
        }
        
       
        let resultString = getValorFormatado(valor: resultado, moedaCode: textDest)
        return resultString
    }
    
}

