//
//  CurrencyLiveViewDataSpec.swift
//  BTGChallengeTests
//
//  Created by Gerson Vieira on 17/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble
import Moya
@testable import BTGChallenge

class CurrencyLiveViewDataTest: QuickSpec {
    
    var convertCurrencyServiceMock: CurrencyLiveServiceContract!
    var convertCurrencyViewModel: CurrencyLiveViewModel!
    var viewData: [CurrencyLiveViewData]!
    
    override func spec() {
        describe("CurrencyLiveViewDataSpec") {
            beforeEach {
                self.convertCurrencyServiceMock = CurrencyLiveServiceMock()
                self.convertCurrencyViewModel  = CurrencyLiveViewModel(service: self.convertCurrencyServiceMock)
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
                self.convertCurrencyServiceMock = nil
                self.convertCurrencyViewModel = nil
                   self.viewData = nil
            }
            
            it("testViewData") {
                expect(self.viewData).toNot(beNil())
                expect(self.viewData[0].currencyCode).to(equal("moeda 1"))
                expect(self.viewData[0].CurrencyQuote).to(equal(3.9))
            }
            
        }
    }
}

