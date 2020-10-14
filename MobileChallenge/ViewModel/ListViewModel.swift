//
//  ListViewModel.swift
//  MobileChallenge
//
//  Created by Thiago de Paula Lourin on 13/10/20.
//

import Foundation

class ListViewModel {
    private(set) var currencyList: [CurrencyType]
    var filteredCurrencyList: [CurrencyType]
    
    init() {
        self.currencyList = CurrencyType.allCases
        self.filteredCurrencyList = []
    }
    
    func getListCount() -> Int {
        return self.currencyList.count
    }
    
    func getFilteredCount() -> Int {
        return self.filteredCurrencyList.count
    }
    
    func getCurrencyCode(index: Int, _ isFiltering: Bool) -> String {
        if isFiltering {
            return String(describing: filteredCurrencyList[index])
        }
        return String(describing: currencyList[index])
    }
    
    func getCurrencyRawValue(index: Int, _ isFiltering: Bool) -> String {
        if isFiltering {
            return filteredCurrencyList[index].rawValue
        }
        return currencyList[index].rawValue
    }
}

enum CurrencyType: String, CaseIterable {
    case AED = "United Arab Emirates Dirham"
    case AFN = "Afghan Afghani"
    case ALL = "Albanian Lek"
    case AMD = "Armenian Dram"
    case ANG = "Netherlands Antillean Guilder"
    case AOA = "Angolan Kwanza"
    case ARS = "Argentine Peso"
    case AUD = "Australian Dollar"
    case AWG = "Aruban Florin"
    case AZN = "Azerbaijani Manat"
    case BAM = "Bosnia-Herzegovina Convertible Mark"
    case BBD = "Barbadian Dollar"
    case BDT = "Bangladeshi Taka"
    case BGN = "Bulgarian Lev"
    case BHD = "Bahraini Dinar"
    case BIF = "Burundian Franc"
    case BMD = "Bermudan Dollar"
    case BND = "Brunei Dollar"
    case BOB = "Bolivian Boliviano"
    case BRL = "Brazilian Real"
    case BSD = "Bahamian Dollar"
    case BTC = "Bitcoin"
    case BTN = "Bhutanese Ngultrum"
    case BWP = "Botswanan Pula"
    case BYN = "New Belarusian Ruble"
    case BYR = "Belarusian Ruble"
    case BZD = "Belize Dollar"
    case CAD = "Canadian Dollar"
    case CDF = "Congolese Franc"
    case CHF = "Swiss Franc"
    case CLF = "Chilean Unit of Account (UF)"
    case CLP = "Chilean Peso"
    case CNY = "Chinese Yuan"
    case COP = "Colombian Peso"
    case CRC = "Costa Rican Colón"
    case CUC = "Cuban Convertible Peso"
    case CUP = "Cuban Peso"
    case CVE = "Cape Verdean Escudo"
    case CZK = "Czech Republic Koruna"
    case DJF = "Djiboutian Franc"
    case DKK = "Danish Krone"
    case DOP = "Dominican Peso"
    case DZD = "Algerian Dinar"
    case EGP = "Egyptian Pound"
    case ERN = "Eritrean Nakfa"
    case ETB = "Ethiopian Birr"
    case EUR = "Euro"
    case FJD = "Fijian Dollar"
    case FKP = "Falkland Islands Pound"
    case GBP = "British Pound Sterling"
    case GEL = "Georgian Lari"
    case GGP = "Guernsey Pound"
    case GHS = "Ghanaian Cedi"
    case GIP = "Gibraltar Pound"
    case GMD = "Gambian Dalasi"
    case GNF = "Guinean Franc"
    case GTQ = "Guatemalan Quetzal"
    case GYD = "Guyanaese Dollar"
    case HKD = "Hong Kong Dollar"
    case HNL = "Honduran Lempira"
    case HRK = "Croatian Kuna"
    case HTG = "Haitian Gourde"
    case HUF = "Hungarian Forint"
    case IDR = "Indonesian Rupiah"
    case ILS = "Israeli New Sheqel"
    case IMP = "Manx pound"
    case INR = "Indian Rupee"
    case IQD = "Iraqi Dinar"
    case IRR = "Iranian Rial"
    case ISK = "Icelandic Króna"
    case JEP = "Jersey Pound"
    case JMD = "Jamaican Dollar"
    case JOD = "Jordanian Dinar"
    case JPY = "Japanese Yen"
    case KES = "Kenyan Shilling"
    case KGS = "Kyrgystani Som"
    case KHR = "Cambodian Riel"
    case KMF = "Comorian Franc"
    case KPW = "North Korean Won"
    case KRW = "South Korean Won"
    case KWD = "Kuwaiti Dinar"
    case KYD = "Cayman Islands Dollar"
    case KZT = "Kazakhstani Tenge"
    case LAK = "Laotian Kip"
    case LBP = "Lebanese Pound"
    case LKR = "Sri Lankan Rupee"
    case LRD = "Liberian Dollar"
    case LSL = "Lesotho Loti"
    case LTL = "Lithuanian Litas"
    case LVL = "Latvian Lats"
    case LYD = "Libyan Dinar"
    case MAD = "Moroccan Dirham"
    case MDL = "Moldovan Leu"
    case MGA = "Malagasy Ariary"
    case MKD = "Macedonian Denar"
    case MMK = "Myanma Kyat"
    case MNT = "Mongolian Tugrik"
    case MOP = "Macanese Pataca"
    case MRO = "Mauritanian Ouguiya"
    case MUR = "Mauritian Rupee"
    case MVR = "Maldivian Rufiyaa"
    case MWK = "Malawian Kwacha"
    case MXN = "Mexican Peso"
    case MYR = "Malaysian Ringgit"
    case MZN = "Mozambican Metical"
    case NAD = "Namibian Dollar"
    case NGN = "Nigerian Naira"
    case NIO = "Nicaraguan Córdoba"
    case NOK = "Norwegian Krone"
    case NPR = "Nepalese Rupee"
    case NZD = "New Zealand Dollar"
    case OMR = "Omani Rial"
    case PAB = "Panamanian Balboa"
    case PEN = "Peruvian Nuevo Sol"
    case PGK = "Papua New Guinean Kina"
    case PHP = "Philippine Peso"
    case PKR = "Pakistani Rupee"
    case PLN = "Polish Zloty"
    case PYG = "Paraguayan Guarani"
    case QAR = "Qatari Rial"
    case RON = "Romanian Leu"
    case RSD = "Serbian Dinar"
    case RUB = "Russian Ruble"
    case RWF = "Rwandan Franc"
    case SAR = "Saudi Riyal"
    case SBD = "Solomon Islands Dollar"
    case SCR = "Seychellois Rupee"
    case SDG = "Sudanese Pound"
    case SEK = "Swedish Krona"
    case SGD = "Singapore Dollar"
    case SHP = "Saint Helena Pound"
    case SLL = "Sierra Leonean Leone"
    case SOS = "Somali Shilling"
    case SRD = "Surinamese Dollar"
    case STD = "São Tomé and Príncipe Dobra"
    case SVC = "Salvadoran Colón"
    case SYP = "Syrian Pound"
    case SZL = "Swazi Lilangeni"
    case THB = "Thai Baht"
    case TJS = "Tajikistani Somoni"
    case TMT = "Turkmenistani Manat"
    case TND = "Tunisian Dinar"
    case TOP = "Tongan Paʻanga"
    case TRY = "Turkish Lira"
    case TTD = "Trinidad and Tobago Dollar"
    case TWD = "New Taiwan Dollar"
    case TZS = "Tanzanian Shilling"
    case UAH = "Ukrainian Hryvnia"
    case UGX = "Ugandan Shilling"
    case USD = "United States Dollar"
    case UYU = "Uruguayan Peso"
    case UZS = "Uzbekistan Som"
    case VEF = "Venezuelan Bolívar Fuerte"
    case VND = "Vietnamese Dong"
    case VUV = "Vanuatu Vatu"
    case WST = "Samoan Tala"
    case XAF = "CFA Franc BEAC"
    case XAG = "Silver (troy ounce)"
    case XAU = "Gold (troy ounce)"
    case XCD = "East Caribbean Dollar"
    case XDR = "Special Drawing Rights"
    case XOF = "CFA Franc BCEAO"
    case XPF = "CFP Franc"
    case YER = "Yemeni Rial"
    case ZAR = "South African Rand"
    case ZMK = "Zambian Kwacha (pre-2013)"
    case ZMW = "Zambian Kwacha"
    case ZWL = "Zimbabwean Dollar"
}
