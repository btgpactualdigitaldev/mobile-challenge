//
//  ButtonDelegate.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

public enum WithAction {
    case origin
    case target
    case submit
}

internal protocol ButtonDelegate: AnyObject {
    func didPressButton(_ action: WithAction)
}
