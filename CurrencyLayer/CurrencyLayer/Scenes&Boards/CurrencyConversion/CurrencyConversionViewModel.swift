import Foundation
import Combine

public class CurrencyConversionViewModel: ObservableObject {
  @Published private(set) var state = CurrencyLayerState()
  private var subscriptions = Set<AnyCancellable>()
  private var fetcher: CurrencyLayerFetcher
  
  init(fetcher: CurrencyLayerFetcher) {
    self.fetcher = fetcher
  }
  
  func fetchCurrecyListAndCurrencies() {
    self.state.isLoading = true
    fetcher.getCurrencyExangeList()
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
              self.state.isLoading = false
              self.subscriptions = []
            case .finished:
              self.state.isLoading = false
              break
            }
          },
          receiveValue: { [weak self] currenciesResponse in
            guard let self = self else { return }
            self.state.exangeRates = currenciesResponse.quotes
            self.fetchSupportedCurrencies()
        })
        .store(in: &subscriptions)
  }
  
  func fetchSupportedCurrencies() {
    fetcher.getSupportedCurrencies()
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
              self.subscriptions = []
              self.state.isLoading = false
            case .finished:
              self.state.isLoading = false
              break
            }
          },
          receiveValue: { [weak self] supportedCurrencies in
            guard let self = self else { return }
            self.state.currencies = supportedCurrencies.currencies
            self.state.isLoading = false

        })
        .store(in: &subscriptions)
  }
}

struct CurrencyLayerState {
  var isLoading = false
  var exangeRates = [String:Double]()
  var currencies = [String:String]()
}
