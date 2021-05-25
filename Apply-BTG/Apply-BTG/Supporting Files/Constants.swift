//
//  Constants.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 21/05/21.
//

import Foundation
import UIKit

/// Struct for some constants of the project
struct Constants {
    // MARK: - API Constants
    
    static let BTG_LIST_ENDPOINT = "https://btg-mobile-challenge.herokuapp.com/list"
    static let BTG_LIVE_ENDPOINT = "https://btg-mobile-challenge.herokuapp.com/live"
        
    
    // MARK: - Storyboard Constants
    static let CELL_IDENTIFIER = "CurrencyTableViewCell"
    
    
    // MARK: - Color Constants
    static let BTG_LOGO_COLOR = "#195AB4"
    
    // MARK: - UserDefaults constants
    static let LIST_CURRENCIES_KEY = "CurrenciesList"
    static let CURRENT_CURRENCY_KEY = "Currency"
    static let QUOTES_KEY = "ConversionQuotes"
    
    // MARK: - Quotes constants
    static let DOLLAR_KEY = "USD"
    
    // MARK: - View components constants
    static let FONT_NAME = "DraftWerk-Regular"
    static let PICKER_VIEW_FONT_SIZE: CGFloat = 18
    static let FONT_COLOR = UIColor.white
    static let BORDER_COLOR = UIColor.white.cgColor
    static let BORDER_WIDTH: CGFloat = 3.0
    static let CORNER_RADIUS: CGFloat = 8
        
    // MARK: - Common constants
    static let BLANK_STRING = ""
    static let PLACEHOLDER_SEARCHBAR = "Insira o nome ou o código da moeda"
    
    // MARK: - My social media links:
    static let LINKEDIN_URL_STRING = "https://www.linkedin.com/in/adrianorodriguesvieira/"
    static let GITHUB_URL_STRING = "https://github.com/AdrianoAntoniev"
    static let STACKOVERFLOW_URL_STRING = "https://stackoverflow.com/users/15342909/adrianoingo"
    static let CODEWARS_URL_STRING = "https://www.codewars.com/users/AdrianoAntoniev"
}
