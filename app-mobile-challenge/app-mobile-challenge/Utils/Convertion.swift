//
//  Convertion.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation


class Convertion {

    // Properties

    private static var lives: Lives { CommonData.shared.lives }

    static func getCurrrency(from: String, to: String, valueFrom: String) -> ((valueFrom: String, valueTo: String)?, String?) {
        if lives.count == 0 {
            return (nil, "Aguarde, os dados estão sendo carrergados, tente novamente em breve.")
        }
        if (from == to) {
            return equals(from, to, valueFrom)
        } else
        if (from == "USD") {
            return fromUSD(to, valueFrom)
        } else
        if (to == "USD") {
            return toUSD(from, valueFrom)
        } else
        {
            return diferents(from, to, valueFrom)
        }
    }
    
    private static func toUSD(_ from: String, _ valueFrom: String) -> ((valueFrom: String, valueTo: String)?, String?) {
        guard let doubleFrom: Double =
                stringToDouble(valueFrom) else {
            return (nil, "Insira um valor válido!")
        }
        guard let liveTo = lives.finOne(by: "USD"+from) else {
            return (nil, "Não foi encontrado um valor para a moeda à ser convertida, tente selecionar uma nova moeda ou recarregar a lista de moedas.")
        }
        let liveValue: Double = liveTo.quote
        let doubleTo: Double =  doubleFrom / liveValue
        let convertedFrom = doubleToCurrent(doubleFrom)
        let convertedTo = doubleToCurrent(doubleTo)
        return (
            (valueFrom: convertedFrom, valueTo: convertedTo),
            nil
        )
    }
    
    private static func fromUSD(_ to: String, _ valueFrom: String) -> ((valueFrom: String, valueTo: String)?, String?) {
        guard let doubleFrom: Double =
                stringToDouble(valueFrom) else {
            return (nil, "Insira um valor válido!")
        }
        guard let liveTo = lives.finOne(by: "USD"+to) else {
            return (nil, "Não foi encontrado um valor para a moeda à ser convertida, tente selecionar uma nova moeda ou recarregar a lista de moedas.")
        }
        let liveValue: Double = liveTo.quote
        let doubleTo: Double = doubleFrom * liveValue
        let convertedFrom = doubleToCurrent(doubleFrom)
        let convertedTo = doubleToCurrent(doubleTo)
        return (
            (valueFrom: convertedFrom, valueTo: convertedTo),
            nil
        )
    }
    
    private static func equals(_ from: String, _ to: String, _ valueFrom: String) -> ((valueFrom: String, valueTo: String)?, String?) {
        guard let doubleFrom: Double =
                stringToDouble(valueFrom) else {
            return (nil, "Insira um valor válido!")
        }
        let convertedFrom = doubleToCurrent(doubleFrom)
        return (
            (valueFrom: convertedFrom, valueTo: convertedFrom),
            nil
        )
    }
    
    private static func diferents(_ from: String, _ to: String, _ valueFrom: String) -> ((valueFrom: String, valueTo: String)?, String?) {
        guard let usdFrom = toUSD(from, valueFrom).0?.valueTo,
              let doubleFrom = stringToDouble(valueFrom),
              let usdTo = fromUSD(to, usdFrom).0?.valueTo else {
            return (nil, "Insira um valor válido!")
        }
        return (
            (doubleToCurrent(doubleFrom), usdTo),
            nil
        )
    }
    
    private static func stringToDouble(_ value: String) -> Double? {
        return Double((value == "" ? "1" :value)
                        .replacingOccurrences(of: ",", with: "."))
    }
    
    private static func doubleToCurrent(_ value: Double) -> String {
        return String(format: "%.02f", value)
            .replacingOccurrences(of: ".", with: ",")
    }
}
