import XCTest
import Domain
import Presenter

class RatesTests: XCTestCase {

    func test_rates_should_show_error_message_if_listQuotes_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let listQuotesSpy = ListQuotesSpy()
        let sut = makeSut(alertView: alertViewSpy, listQuotes: listQuotesSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.list()
        listQuotesSpy.completedWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_rates_should_show_loading_before_and_after_call_listQuotes() throws {
        let loadingViewSpy = LoadingViewSpy()
        let listQuotesSpy = ListQuotesSpy()
        let sut = makeSut(listQuotes: listQuotesSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.list()
        wait(for: [exp], timeout: 1)
        let expHiddenLoading = expectation(description: "waiting")
        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            expHiddenLoading.fulfill()
        }
        listQuotesSpy.completedWithError(.unexpected)
        wait(for: [expHiddenLoading], timeout: 1)
    }
    
    func test_rates_should_show_success_message_if_listQuotes_succeeds() throws {
        let alertViewSpy = AlertViewSpy()
        let listQuotesSpy = ListQuotesSpy()
        let sut = makeSut(alertView: alertViewSpy, listQuotes: listQuotesSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer {  viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertViewModel(message: "Cotas baixadas com sucesso."))
            exp.fulfill()
        }
        sut.list()
        listQuotesSpy.completedWithData(makeQuotesModel())
        wait(for: [exp], timeout: 1)
    }
}

extension RatesTests {
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), listQuotes: ListQuotesSpy = ListQuotesSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), file: StaticString = #filePath, line: UInt = #line) -> RatesPresenter {

        let sut = RatesPresenter(alertView: alertView, listQuotes: listQuotes, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }    
}
