import Foundation
import Presenter

class LoadingViewSpy: LoadingView {
    var emit: ((LoadingViewModel) -> Void)?
    
    func observer(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
