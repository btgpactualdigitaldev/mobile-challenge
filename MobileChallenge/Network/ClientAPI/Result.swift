//
//  Result.swift
//  MobileChallenge
//
//  Created by Thiago Lourin on 13/10/20.
//

import Foundation

public enum Result<Value> {
    case success(APIResponse?)
    case failure(String)
}

typealias ResultCallback<Value> = (Result<Value>) -> Void
