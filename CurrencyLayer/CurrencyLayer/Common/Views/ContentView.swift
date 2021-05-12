import SwiftUI

struct ContentView: View {
    var screenHeight = UIScreen.main.bounds.height
    private var viewModel = CurrencyConversionViewModel(fetcher: CurrencyLayerFetcher())
    var body: some View {
      CurrencyConversionView(viewModel: viewModel)
        .onAppear(perform: viewModel.fetchCurrecyListAndCurrencies)
    }
}
