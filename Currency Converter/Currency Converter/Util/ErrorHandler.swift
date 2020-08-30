//
//  ErrorHandler.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 29/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit

extension NSError {
    func parsedErrorForHTTPStatusCode(_ httpStatusCode: Int) -> NSError {
        switch httpStatusCode {
            case 13:
                return NSError(domain: self.domain,
                               code: 13,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas na conexão",
                                NSLocalizedRecoverySuggestionErrorKey: "Verifique sua conexão e tente novamente"])
            case 101:
                return NSError(domain: self.domain,
                               code: 101,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "Chave de acesso inexistente ou inválida"])
            case 102:
                return NSError(domain: self.domain,
                               code: 102,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "Conta inativa, entre em contato com o suporte"])
            case 103:
                return NSError(domain: self.domain,
                               code: 103,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "A função não existe nesta API"])
            case 104:
                return NSError(domain: self.domain,
                               code: 104,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "O usuário atingiu ou excedeu a cota mensal para uso desta API"])
            case 105:
                return NSError(domain: self.domain,
                               code: 105,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "O usuário autal não tem suporte para esta função da API"])
            case 106:
                return NSError(domain: self.domain,
                               code: 106,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao carregar informações",
                                NSLocalizedRecoverySuggestionErrorKey: "A pesquisa não retornou resultados"])
            case 201:
                return NSError(domain: self.domain,
                               code: 201,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao carregar informações",
                                NSLocalizedRecoverySuggestionErrorKey: "Moeda de origem inexistente"])
            case 202:
                return NSError(domain: self.domain,
                               code: 202,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao carregar informações",
                                NSLocalizedRecoverySuggestionErrorKey: "Um ou mais códigos de moeda inexistentes"])
            case 301:
                return NSError(domain: self.domain,
                               code: 301,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao carregar informações",
                                NSLocalizedRecoverySuggestionErrorKey: "Nenhuma data providenciada"])
            case 302:
                return NSError(domain: self.domain,
                               code: 302,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao carregar informações",
                                NSLocalizedRecoverySuggestionErrorKey: "Data inválida"])
            case 401:
                return NSError(domain: self.domain,
                               code: 401,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao carregar informações",
                                NSLocalizedRecoverySuggestionErrorKey: "Propriedade \"from\" inválida"])
            case 402:
                return NSError(domain: self.domain,
                               code: 402,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao carregar informações",
                                NSLocalizedRecoverySuggestionErrorKey: "Propriedade \"to\" inválida"])
            case 403:
                return NSError(domain: self.domain,
                               code: 403,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "Propriedade \"amount\" inválida"])
            case 404:
                    return NSError(domain: self.domain,
                                   code: 404,
                                   userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                    NSLocalizedRecoverySuggestionErrorKey: "Aparentemente o conteúdo requisitado não existe"])
            case 501:
                return NSError(domain: self.domain,
                               code: 501,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "Nenhum intervalo de tempo especificado"])
            case 502:
                return NSError(domain: self.domain,
                               code: 502,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "Propriedade \"start_date\" inválida"])
            case 503:
                return NSError(domain: self.domain,
                               code: 503,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "Propriedade \"end_date\" inválida"])
            case 504:
                return NSError(domain: self.domain,
                               code: 504,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "Intervalo de tempo inválido"])
            case 505:
                return NSError(domain: self.domain,
                               code: 505,
                               userInfo: [NSLocalizedDescriptionKey: "Problemas ao acessar",
                                NSLocalizedRecoverySuggestionErrorKey: "Intervalo de tempo especificado extrapola 385 dias"])
            default:
                return NSError(domain: self.domain,
                               code: httpStatusCode,
                               userInfo: [NSLocalizedDescriptionKey: "Ocorreu um erro",
                                NSLocalizedRecoverySuggestionErrorKey: "Se o erro persistir entre em contato com o suporte"])
        }        
    }
}
