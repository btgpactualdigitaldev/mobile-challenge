import Foundation
import Domain
import UI
import Presenter

public final class RatesComposer {
    public static func composeControllerWith(listQuotes: ListQuotes) -> RatesViewController {
        let controller = RatesViewController.instantiate()
        let presenter = RatesPresenter(alertView: WeakVarProxy(controller), listQuotes: listQuotes, loadingView: WeakVarProxy(controller))
        controller.listQuotes = presenter.list
        return controller
    }
}
