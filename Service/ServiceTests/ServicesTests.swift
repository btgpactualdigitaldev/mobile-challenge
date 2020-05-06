//
//  ServiceTests.swift
//  ServiceTests
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import XCTest
@testable import Service

fileprivate enum SomeService {
    case type1
    case type2
}

class ServicesTests: XCTestCase {

    func testMakingService() {
        let services = Services.default
        services.register(SomeService.self) { SomeService.type1 }
        let instance: SomeService = services.make(for: SomeService.self)
        XCTAssert(instance == SomeService.type1, "Service instance isn't the same as the registered.")
    }

    func testMakingServiceAndReadingAnother() {
        let services = Services.default
        services.register(SomeService.self) { SomeService.type2 }
        let instance: SomeService = services.make(for: SomeService.self)
        XCTAssert(instance != SomeService.type1, "Service instance is the same as the registered.")
    }
}
