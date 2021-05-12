import SwiftUI
import Combine

var screenHeight = UIScreen.main.bounds.height

struct CurrencyConversionView: View {
 @ObservedObject var viewModel: CurrencyConversionViewModel

 @State var fromInput = ""
 @State var currencyFrom: String = "USD"
 @State var currencyTo: String = "USD"
 @State var exchangeResult: String = "0.0"

  var body: some View {
    NavigationView {
      ZStack {
        Color.init("color_primary_background").edgesIgnoringSafeArea(.all)
        if viewModel.state.isLoading {
          loadingIndicator
        } else if !viewModel.state.isLoading {
          content
        }
      }
      .toolbar {
        ToolbarItem(placement: .principal) { Text("Currency Layer").foregroundColor(Color.white) }
      }
    }
  }
  
  private var loadingIndicator: some View {
    ActivityIndicator(isAnimating: .constant(true), style: .large, color: .gray)
      .frame(maxWidth: .infinity, alignment: .center)
  }
}

extension CurrencyConversionView {
  private var content: some View {
    return
      VStack(alignment: .leading) {
        VStack(spacing: screenHeight/3) {
          HStack(alignment: .center, spacing: 26) {
            NavigationLink(destination: AvailableCurrencies(currencies: viewModel.state.currencies, currencyItem: $currencyFrom)) {
              CurrecyButton(currencyItem: $currencyFrom)
            }
            VStack() {
              CurrencyInput(model: CurrencyInputModel(txt: $fromInput))
              Divider()
               .frame(height: 1)
               .padding(.horizontal, 30)
               .background(Color.white)
            }
          }
          VStack() {
            HStack(alignment: .center) {
              NavigationLink(destination: AvailableCurrencies(currencies: viewModel.state.currencies, currencyItem: $currencyTo)) {
                CurrecyButton(currencyItem: $currencyTo)
              }
              Spacer()
              Text(String(exchangeResult))
                .font(.title3)
                .lineLimit(1)
                .lineSpacing(50)
                .foregroundColor(Color.white)
                .frame(width: 150, height: 100, alignment: .trailing)
            }
          }
        }
        .padding(16)
        Spacer()
        Button(action: {
          exchangeResult = String(format: "%.2f",
                                 Calculator(exanges: viewModel.state.exangeRates)
                                    .exanges(valueToConvert: (Double(fromInput) ?? 0.0)/100,
                                            currecyToConvert: currencyTo,
                                            currencyFromConvert: currencyFrom)
          )
        }) {
          Text("Calculate")
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(.system(size: 18))
            .padding()
            .foregroundColor(.white)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.white)
    }
  }
}
