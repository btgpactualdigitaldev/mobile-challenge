import Foundation

protocol QuotesRequestProtocol {
    func getMovies(onComplete: @escaping (Quotes) -> Void, onError: @escaping (CurrencyQuotesError) -> Void)
}

class QuotesRequest {
    func getQuotes(onComplete: @escaping (Quotes) -> Void, onError: @escaping (CurrencyQuotesError) -> Void) {
        //MARK: - Sessão
        let session = URLSession.shared
        
        //MARK: - Requisição
        let basePath = "http://api.currencylayer.com/"
        let typeOfInfo = "live?access_"
        let key = "key=646f0fac891628950bbae45c08460ffe"
        guard let url = URL(string: basePath + typeOfInfo + key) else {
            onError(.url)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        //MARK: - Tratamento de dados
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
                        let quotes = try jsonDecoder.decode(Quotes.self, from: data)
                        onComplete(quotes)
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
