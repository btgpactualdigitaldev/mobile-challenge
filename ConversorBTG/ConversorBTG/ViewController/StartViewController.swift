//
//  StartViewController.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit
import Network

//Classe da View que inicia o aplicativo
class StartViewController: UIViewController{
    
    //MARK: Atributos
    
    ///Referencia a todas as moedas
    var allCurrencies = [Currency]()
    ///Atributo que monitorará a conexão com a internet
    private let monitor = NWPathMonitor()
    ///Atributo que salva o resultado da checagem da conexão a internet
    private var internetStatus = false
    ///Contador para a tela não ficar presa em looping caso seja a primeira requisição e não tenha acesso a internet
    private var count = 0
    
    //Círculos para animar a tela de carregamento
    @IBOutlet weak var blueCircle: UIImageView!
    @IBOutlet weak var redCircle: UIImageView!
    @IBOutlet weak var greenCircle: UIImageView!
    
    //MARK: Métodos
    
    /**
     Método de inicialização pós carregamento da View
     - Warning: ⚠️Assim que iniciada, as requsições as APIS começam e a animação de carregamento também
     - Parameters:none
     - Returns: none
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        //inicia o monitoramento a conexão
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { path in
           if path.status == .satisfied {
            print("Conectado")
            self.internetStatus = true
           } else {
            print("DesConectado")
            self.internetStatus = false
           }
            if self.internetStatus {
                self.getApiData()
            }else{
                self.allCurrencies = CurrencyDataManager().readData()
            }
        }
        self.goAnimation()
    }
    
    /**
     Método que inicia a requisição
     - Warning: none
     - Parameters:none
     - Returns: none
     */
    func getApiData(){
        let apiDM = ApiDataManager(delegate: self)
    }
    
    /**
     Método que descreve a animação de carregamento da tela e coloca a thread inicial para monitorar o resultado da API
     - Warning: ⚠️A tela de carregamento entra em looping e sai após a requisição ser concluida, caso não haja acesso a internet e já tenha dados salvos no core data ou caso o contador conte 10 segundos.
     - Parameters:none
     - Returns: none
     */
    func goAnimation(){
        UIView.animateKeyframes(
            withDuration: 1.0, delay: 0.0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    self.blueCircle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                    self.redCircle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.6) {
                    self.greenCircle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5 )
                }
            }, completion: {_ in
                //Verifica se a requisição terminou
                if self.allCurrencies.count > 0{
                    self.performSegue(withIdentifier: "startApp", sender: nil)
                }else{
                    self.count += 1
                    self.backAnimation()
                }
            })
    }
    
    /**
     Método que descreve a animação de carregamento da tela e coloca a thread inicial para monitorar o resultado da API
     - Warning: ⚠️A tela de carregamento entra em looping e sai após a requisição ser concluida, caso não haja acesso a internet e já tenha dados salvos no core data ou caso o contador conte 10 segundos.
     - Parameters:none
     - Returns: none
     */
    func backAnimation(){
        UIView.animateKeyframes(
            withDuration: 1.0, delay: 0.0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    self.blueCircle.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                    self.redCircle.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.6) {
                    self.greenCircle.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
            }, completion: {_ in
                if self.allCurrencies.count > 0 || self.count > 10{
                    self.performSegue(withIdentifier: "startApp", sender: nil)
                }else{
                    self.count += 1
                    self.goAnimation()
                }
            })
    }
   
    /**
     Método que prepara os dados para navegar para uma próxima tela
     - Warning: ⚠️É nesse método que passamos o resultado da requisição para a próxima tela
     - Parameters:
        - segue: UIStoryboardSegue - segue que será executada
     - Returns: none
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.monitor.cancel()
        let destination = segue.destination as! TabBarController
        destination.allCurrencies = self.allCurrencies
    }

}
