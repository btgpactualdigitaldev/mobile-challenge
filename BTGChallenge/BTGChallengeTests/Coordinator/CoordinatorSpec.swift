//
//  CoordinatorSpec.swift
//  BTGChallengeTests
//
//  Created by Gerson Vieira on 17/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble
@testable import BTGChallenge

class CoordinatorSpec: QuickSpec {
    
    var appCoordinator: AppCoordinator!
    var defaultWindow: UIWindow!
    
    override func spec() {
        
        describe("CoordinatorSpec"){
            beforeEach {
                self.defaultWindow = UIWindow()
                self.appCoordinator = AppCoordinator(with: self.defaultWindow)
                let _ = self.appCoordinator.start(with: .push(animated: true))
            }
            
            afterEach {
                self.appCoordinator = nil
            }
            
            it ("testAddSameCoordinator") {
                let newCoordinator = AppCoordinator(with: self.defaultWindow)
                self.appCoordinator.addChildCoordinator(newCoordinator)
                
                let countChildCoordinator = self.appCoordinator.childCoordinators.count
                self.appCoordinator.addChildCoordinator(newCoordinator)
                
                let newCountChildCoordinators = self.appCoordinator.childCoordinators.count
                expect(countChildCoordinator).to(equal(newCountChildCoordinators))
            }
            
            it("Remove child Coordinator") {
                let newCoordinator = AppCoordinator(with: self.defaultWindow)
                self.appCoordinator.addChildCoordinator(newCoordinator)
                let countChildCoordinators = self.appCoordinator.childCoordinators.count
                
                self.appCoordinator.removeChildCoordinator(newCoordinator)
                let newCountChildCoordinators = self.appCoordinator.childCoordinators.count
                expect(newCountChildCoordinators).to(equal(countChildCoordinators  - 1))
                
            }
            
            it("Remoce child coordinator emptyList") {
                let newCoordinator = AppCoordinator(with: self.defaultWindow)
                let countChildCoordinators = self.appCoordinator.childCoordinators.count
                
                self.appCoordinator.removeChildCoordinator(newCoordinator)
                let newCountChildCoordinators = self.appCoordinator.childCoordinators.count
                
                expect(newCountChildCoordinators).to(equal(countChildCoordinators))
            }
        }
        
    }
}
