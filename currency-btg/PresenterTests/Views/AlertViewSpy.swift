import Foundation
import Presenter

class AlertViewSpy: AlertView {
    var emit: ((AlertViewModel) -> Void)?
    
    func observer(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }
    
    func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
}
