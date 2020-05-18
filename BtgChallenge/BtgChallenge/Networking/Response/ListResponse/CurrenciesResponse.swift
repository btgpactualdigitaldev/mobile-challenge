//
//  CurrenciesResponse.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 15/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

class CurrenciesResponse: NSObject, Codable {
    var AED: String?
    var AFN: String?
    var ALL: String?
    var AMD: String?
    var ANG: String?
    var AOA: String?
    var ARS: String?
    var AUD: String?
    var AWG: String?
    var AZN: String?
    var BAM: String?
    var BBD: String?
    var BDT: String?
    var BGN: String?
    var BHD: String?
    var BIF: String?
    var BMD: String?
    var BND: String?
    var BOB: String?
    var BRL: String?
    var BSD: String?
    var BTC: String?
    var BTN: String?
    var BWP: String?
    var BYR: String?
    var BZD: String?
    var CAD: String?
    var CDF: String?
    var CHF: String?
    var CLF: String?
    var CLP: String?
    var CNY: String?
    var COP: String?
    var CRC: String?
    var CUC: String?
    var CUP: String?
    var CVE: String?
    var CZK: String?
    var DJF: String?
    var DKK: String?
    var DOP: String?
    var DZD: String?
    var EGP: String?
    var ERN: String?
    var ETB: String?
    var EUR: String?
    var FJD: String?
    var FKP: String?
    var GBP: String?
    var GEL: String?
    var GGP: String?
    var GHS: String?
    var GIP: String?
    var GMD: String?
    var GNF: String?
    var GTQ: String?
    var GYD: String?
    var HKD: String?
    var HNL: String?
    var HRK: String?
    var HTG: String?
    var HUF: String?
    var IDR: String?
    var ILS: String?
    var IMP: String?
    var INR: String?
    var IQD: String?
    var IRR: String?
    var ISK: String?
    var JEP: String?
    var JMD: String?
    var JOD: String?
    var JPY: String?
    var KES: String?
    var KGS: String?
    var KHR: String?
    var KMF: String?
    var KPW: String?
    var KRW: String?
    var KWD: String?
    var KYD: String?
    var KZT: String?
    var LAK: String?
    var LBP: String?
    var LKR: String?
    var LRD: String?
    var LSL: String?
    var LTL: String?
    var LVL: String?
    var LYD: String?
    var MAD: String?
    var MDL: String?
    var MGA: String?
    var MKD: String?
    var MMK: String?
    var MNT: String?
    var MOP: String?
    var MRO: String?
    var MUR: String?
    var MVR: String?
    var MWK: String?
    var MXN: String?
    var MYR: String?
    var MZN: String?
    var NAD: String?
    var NGN: String?
    var NIO: String?
    var NOK: String?
    var NPR: String?
    var NZD: String?
    var OMR: String?
    var PAB: String?
    var PEN: String?
    var PGK: String?
    var PHP: String?
    var PKR: String?
    var PLN: String?
    var PYG: String?
    var QAR: String?
    var RON: String?
    var RSD: String?
    var RUB: String?
    var RWF: String?
    var SAR: String?
    var SBD: String?
    var SCR: String?
    var SDG: String?
    var SEK: String?
    var SGD: String?
    var SHP: String?
    var SLL: String?
    var SOS: String?
    var SRD: String?
    var STD: String?
    var SVC: String?
    var SYP: String?
    var SZL: String?
    var THB: String?
    var TJS: String?
    var TMT: String?
    var TND: String?
    var TOP: String?
    var TRY: String?
    var TTD: String?
    var TWD: String?
    var TZS: String?
    var UAH: String?
    var UGX: String?
    var USD: String?
    var UYU: String?
    var UZS: String?
    var VEF: String?
    var VND: String?
    var VUV: String?
    var WST: String?
    var XAF: String?
    var XAG: String?
    var XAU: String?
    var XCD: String?
    var XDR: String?
    var XOF: String?
    var XPF: String?
    var YER: String?
    var ZAR: String?
    var ZMK: String?
    var ZMW: String?
    var ZWL: String?
}

extension CurrenciesResponse {
    var coinStrategy: [String: String?] {
        return [
            "AED": AED,
            "AFN": AFN,
            "ALL": ALL,
            "AMD": AMD,
            "ANG": ANG,
            "AOA": AOA,
            "ARS": ARS,
            "AUD": AUD,
            "AWG": AWG,
            "AZN": AZN,
            "BAM": BAM,
            "BBD": BBD,
            "BDT": BDT,
            "BGN": BGN,
            "BHD": BHD,
            "BIF": BIF,
            "BMD": BMD,
            "BND": BND,
            "BOB": BOB,
            "BRL": BRL,
            "BSD": BSD,
            "BTC": BTC,
            "BTN": BTN,
            "BWP": BWP,
            "BYR": BYR,
            "BZD": BZD,
            "CAD": CAD,
            "CDF": CDF,
            "CHF": CHF,
            "CLF": CLF,
            "CLP": CLP,
            "CNY": CNY,
            "COP": COP,
            "CRC": CRC,
            "CUC": CUC,
            "CUP": CUP,
            "CVE": CVE,
            "CZK": CZK,
            "DJF": DJF,
            "DKK": DKK,
            "DOP": DOP,
            "DZD": DZD,
            "EGP": EGP,
            "ERN": ERN,
            "ETB": ETB,
            "EUR": EUR,
            "FJD": FJD,
            "FKP": FKP,
            "GBP": GBP,
            "GEL": GEL,
            "GGP": GGP,
            "GHS": GHS,
            "GIP": GIP,
            "GMD": GMD,
            "GNF": GNF,
            "GTQ": GTQ,
            "GYD": GYD,
            "HKD": HKD,
            "HNL": HNL,
            "HRK": HRK,
            "HTG": HTG,
            "HUF": HUF,
            "IDR": IDR,
            "ILS": ILS,
            "IMP": IMP,
            "INR": INR,
            "IQD": IQD,
            "IRR": IRR,
            "ISK": ISK,
            "JEP": JEP,
            "JMD": JMD,
            "JOD": JOD,
            "JPY": JPY,
            "KES": KES,
            "KGS": KGS,
            "KHR": KHR,
            "KMF": KMF,
            "KPW": KPW,
            "KRW": KRW,
            "KWD": KWD,
            "KYD": KYD,
            "KZT": KZT,
            "LAK": LAK,
            "LBP": LBP,
            "LKR": LKR,
            "LRD": LRD,
            "LSL": LSL,
            "LTL": LTL,
            "LVL": LVL,
            "LYD": LYD,
            "MAD": MAD,
            "MDL": MDL,
            "MGA": MGA,
            "MKD": MKD,
            "MMK": MMK,
            "MNT": MNT,
            "MOP": MOP,
            "MRO": MRO,
            "MUR": MUR,
            "MVR": MVR,
            "MWK": MWK,
            "MXN": MXN,
            "MYR": MYR,
            "MZN": MZN,
            "NAD": NAD,
            "NGN": NGN,
            "NIO": NIO,
            "NOK": NOK,
            "NPR": NPR,
            "NZD": NZD,
            "OMR": OMR,
            "PAB": PAB,
            "PEN": PEN,
            "PGK": PGK,
            "PHP": PHP,
            "PKR": PKR,
            "PLN": PLN,
            "PYG": PYG,
            "QAR": QAR,
            "RON": RON,
            "RSD": RSD,
            "RUB": RUB,
            "RWF": RWF,
            "SAR": SAR,
            "SBD": SBD,
            "SCR": SCR,
            "SDG": SDG,
            "SEK": SEK,
            "SGD": SGD,
            "SHP": SHP,
            "SLL": SLL,
            "SOS": SOS,
            "SRD": SRD,
            "STD": STD,
            "SVC": SVC,
            "SYP": SYP,
            "SZL": SZL,
            "THB": THB,
            "TJS": TJS,
            "TMT": TMT,
            "TND": TND,
            "TOP": TOP,
            "TRY": TRY,
            "TTD": TTD,
            "TWD": TWD,
            "TZS": TZS,
            "UAH": UAH,
            "UGX": UGX,
            "USD": USD,
            "UYU": UYU,
            "UZS": UZS,
            "VEF": VEF,
            "VND": VND,
            "VUV": VUV,
            "WST": WST,
            "XAF": XAF,
            "XAG": XAG,
            "XAU": XAU,
            "XCD": XCD,
            "XDR": XDR,
            "XOF": XOF,
            "XPF": XPF,
            "YER": YER,
            "ZAR": ZAR,
            "ZMK": ZMK,
            "ZMW": ZMW,
            "ZWL": ZWL
        ]
    }
}
