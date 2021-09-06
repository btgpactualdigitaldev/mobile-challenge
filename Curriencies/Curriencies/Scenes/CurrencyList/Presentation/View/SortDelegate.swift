//
//  SortDelegate.swift
//  Curriencies
//
//  Created by Ferraz on 05/09/21.
//

enum SortType {
    case name
    case code
}

protocol SortDelegate {
    func sortList(type: SortType)
}
