//
//  ViewConfiguration.swift
//  Curriencies
//
//  Created by Ferraz on 31/08/21.
//

protocol ViewConfiguration: AnyObject {
    func setupView()
    func buildHierarchy()
    func makeConstraints()
    func additionalConfigs()
}

extension ViewConfiguration {
    func setupView() {
        buildHierarchy()
        makeConstraints()
        additionalConfigs()
    }
    
    func additionalConfigs() {}
}
