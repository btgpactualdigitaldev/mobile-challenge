//
//  CurrencyListViewDataTest.swift
//  BTGChallengeTests
//
//  Created by Gerson Vieira on 17/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble
import Moya
@testable import BTGChallenge

class CurrencyListViewDataTest: QuickSpec {
    
    var currencyListServiceMock: CurrencyListServiceContract!
    var convertCurrencyViewModel: CurrencyListViewModel!
    var viewData: [CurrencyListViewData]!
    
    override func spec() {
        describe("CurrencyListViewDataSpec") {
            beforeEach {
                self.currencyListServiceMock = CurrencyListServiceMock()
                self.convertCurrencyViewModel  = CurrencyListViewModel(service: self.currencyListServiceMock)
                self.convertCurrencyViewModel.fetch { result in
                    switch result {
                    case .success(let data):
                        self.viewData = data
                    case .failure:
                        return
                    }
                }
            }
            
            afterEach {
                self.currencyListServiceMock = nil
                self.convertCurrencyViewModel = nil
                self.viewData = nil
            }
            
            it("testViewData") {
                expect(self.viewData).toNot(beNil())
                expect(self.viewData[0].currencyCode).to(equal("BRL"))
                expect(self.viewData[0].currencyName).to(equal("Brasil"))
            }
            
        }
    }
}


