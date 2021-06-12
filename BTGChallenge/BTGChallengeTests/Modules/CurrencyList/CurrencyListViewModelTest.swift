//
//  CurrencyListViewModel.swift
//  BTGChallengeTests
//
//  Created by Gerson Vieira on 17/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble
import Moya
@testable import BTGChallenge

class CurrencyListViewModelTest: QuickSpec {
    
    var currencyListServiceMock: CurrencyListServiceContract!
    var currencyListViewModel: CurrencyListViewModel!
    
    override func spec() {
        
        describe("ConvertCurrencyViewModelSpec") {
            beforeEach {
                self.currencyListServiceMock = CurrencyListServiceMock()
                self.currencyListViewModel  = CurrencyListViewModel(service: self.currencyListServiceMock)
            }
            
            afterEach {
                self.currencyListServiceMock = nil
                self.currencyListViewModel = nil
            }
            
            it("testeMockFromService") {
    
                var viewData: [CurrencyListViewData]? = nil
                
                self.currencyListViewModel.fetch { result in
                    switch result {
                    case .success(let response):
                        viewData = response
                    case .failure(_):
                        return
                    }
                }
                
                let expectationViewData = 3
                let currentViewDataListCount = viewData?.count ?? -1
                
                expect(viewData).toNot(beNil())
                expect(currentViewDataListCount).to(equal(expectationViewData))
            }
        }
    }
}
