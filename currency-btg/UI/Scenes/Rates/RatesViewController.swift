import Foundation
import UIKit
import Presenter

public final class RatesViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    public var listQuotes: (() -> Void)?
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        listQuotes?()
    }
}

extension RatesViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator?.startAnimating()
        } else {
            loadingIndicator?.stopAnimating()
        }
    }
}

extension RatesViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
