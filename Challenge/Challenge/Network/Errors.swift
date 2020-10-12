//
//  Errors.swift
//  Challenge
//
//  Created by Eduardo Raffi on 11/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

internal class Errors {
    
    static internal func getErrorDescritption(errorCode: Int) -> String{
        switch errorCode {
        case 404:
            return "User requested a resource which does not exist."
        case 101:
            return "User did not supply an access key or supplied an invalid access key."
        case 103:
            return "User requested a non-existent API function."
        case 104:
            return "User has reached or exceeded his subscription plan's monthly API request allowance."
        case 105:
            return "The user's current subscription plan does not support the requested API function."
        case 106:
            return "The user's query did not return any results"
        case 102:
            return "The user's account is not active. User will be prompted to get in touch with Customer Support."
        case 201:
            return "User entered an invalid Source Currency."
        case 202:
            return "User entered one or more invalid currency codes."
        case 301:
            return "User did not specify a date. [historical]"
        case 302:
            return "User entered an invalid date. [historical, convert]"
        case 401:
            return "User entered an invalid \"from\" property. [convert]"
        case 402:
            return "User entered an invalid \"to\" property. [convert]"
        case 403:
            return "User entered no or an invalid \"amount\" property. [convert]"
        case 501:
            return "User did not specify a Time-Frame. [timeframe, convert]."
        case 502:
            return "User entered an invalid \"start_date\" property. [timeframe, convert]."
        case 503:
            return "User entered an invalid \"end_date\" property. [timeframe, convert]."
        case 504:
            return "User entered an invalid Time-Frame. [timeframe, convert]"
        case 505:
            return "The Time-Frame specified by the user is too long - exceeding 365 days. [timeframe]"
        default:
            return "Unknown error"
        }
    }
    
}
