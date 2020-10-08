import XCTest
import Main
import UI

class RatesComposerTests: XCTestCase {

    func test_ui_presentation_integration() throws {
        let (sut, listQuotesSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.listQuotes?()
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            listQuotesSpy.completedWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

extension RatesComposerTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: RatesViewController, listQuotesSpy: ListQuotesSpy) {
        let listQuotesSpy = ListQuotesSpy()
        let sut = RatesComposer.composeControllerWith(listQuotes: ListQuotesSpy())
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: listQuotesSpy, file: file, line: line)
        return (sut, listQuotesSpy)
    }
}
