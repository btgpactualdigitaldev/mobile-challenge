import Foundation

protocol CurrencyRequestProtocol {
    func getCurrency(onComplete: @escaping (Currencies) -> Void, onError: @escaping (CurrencyQuotesError) -> Void)
}

class CurrencyRequest {
    func getCurrency(onComplete: @escaping (Currencies) -> Void, onError: @escaping (CurrencyQuotesError) -> Void) {
        
        //MARK: - Sessão
        let session = URLSession.shared
        
        //MARK: - Requisição
        let basePath = "http://api.currencylayer.com/"
        let typeOfInfo = "list?access_"
        let key = "key=646f0fac891628950bbae45c08460ffe"
        guard let url = URL(string: basePath + typeOfInfo + key) else {
            onError(.url)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        //MARK: - Tratamento dos dados
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200 {
                    guard  let data = data else { return }
                    do {
                        let jsonDecoder = JSONDecoder()
                        let currencies = try jsonDecoder.decode(Currencies.self, from: data)
                        onComplete(currencies)
                    } catch {
                        print(error.localizedDescription)
                        onError(.invalidJSON)
                    }
                } else {
                    onError(.responseStatusCode(cod: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
}
