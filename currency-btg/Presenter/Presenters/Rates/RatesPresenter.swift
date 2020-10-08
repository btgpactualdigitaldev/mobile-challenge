import Foundation
import Domain

public class RatesPresenter {
    private var alertView: AlertView
    private let listQuotes: ListQuotes
    private let loadingView: LoadingView
    
    public init(alertView: AlertView, listQuotes: ListQuotes, loadingView: LoadingView) {
        self.alertView = alertView
        self.listQuotes = listQuotes
        self.loadingView = loadingView
    }
    
    public func list() {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        listQuotes.list { [weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
            case .failure:
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            case .success(let data):
                debugPrint(data)
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Cotas baixadas com sucesso."))
            }
        }
    }
}
