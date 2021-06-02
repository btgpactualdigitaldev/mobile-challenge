//
//  Currencies.swift
//  Conversor de moedas
//
//  Created by Matheus Duraes on 21/12/20.
//

import Foundation
struct Currencies : Codable {
    let aED : String?
    let aFN : String?
    let aLL : String?
    let aMD : String?
    let aNG : String?
    let aOA : String?
    let aRS : String?
    let aUD : String?
    let aWG : String?
    let aZN : String?
    let bAM : String?
    let bBD : String?
    let bDT : String?
    let bGN : String?
    let bHD : String?
    let bIF : String?
    let bMD : String?
    let bND : String?
    let bOB : String?
    let bRL : String?
    let bSD : String?
    let bTC : String?
    let bTN : String?
    let bWP : String?
    let bYN : String?
    let bYR : String?
    let bZD : String?
    let cAD : String?
    let cDF : String?
    let cHF : String?
    let cLF : String?
    let cLP : String?
    let cNY : String?
    let cOP : String?
    let cRC : String?
    let cUC : String?
    let cUP : String?
    let cVE : String?
    let cZK : String?
    let dJF : String?
    let dKK : String?
    let dOP : String?
    let dZD : String?
    let eGP : String?
    let eRN : String?
    let eTB : String?
    let eUR : String?
    let fJD : String?
    let fKP : String?
    let gBP : String?
    let gEL : String?
    let gGP : String?
    let gHS : String?
    let gIP : String?
    let gMD : String?
    let gNF : String?
    let gTQ : String?
    let gYD : String?
    let hKD : String?
    let hNL : String?
    let hRK : String?
    let hTG : String?
    let hUF : String?
    let iDR : String?
    let iLS : String?
    let iMP : String?
    let iNR : String?
    let iQD : String?
    let iRR : String?
    let iSK : String?
    let jEP : String?
    let jMD : String?
    let jOD : String?
    let jPY : String?
    let kES : String?
    let kGS : String?
    let kHR : String?
    let kMF : String?
    let kPW : String?
    let kRW : String?
    let kWD : String?
    let kYD : String?
    let kZT : String?
    let lAK : String?
    let lBP : String?
    let lKR : String?
    let lRD : String?
    let lSL : String?
    let lTL : String?
    let lVL : String?
    let lYD : String?
    let mAD : String?
    let mDL : String?
    let mGA : String?
    let mKD : String?
    let mMK : String?
    let mNT : String?
    let mOP : String?
    let mRO : String?
    let mUR : String?
    let mVR : String?
    let mWK : String?
    let mXN : String?
    let mYR : String?
    let mZN : String?
    let nAD : String?
    let nGN : String?
    let nIO : String?
    let nOK : String?
    let nPR : String?
    let nZD : String?
    let oMR : String?
    let pAB : String?
    let pEN : String?
    let pGK : String?
    let pHP : String?
    let pKR : String?
    let pLN : String?
    let pYG : String?
    let qAR : String?
    let rON : String?
    let rSD : String?
    let rUB : String?
    let rWF : String?
    let sAR : String?
    let sBD : String?
    let sCR : String?
    let sDG : String?
    let sEK : String?
    let sGD : String?
    let sHP : String?
    let sLL : String?
    let sOS : String?
    let sRD : String?
    let sTD : String?
    let sVC : String?
    let sYP : String?
    let sZL : String?
    let tHB : String?
    let tJS : String?
    let tMT : String?
    let tND : String?
    let tOP : String?
    let tRY : String?
    let tTD : String?
    let tWD : String?
    let tZS : String?
    let uAH : String?
    let uGX : String?
    let uSD : String?
    let uYU : String?
    let uZS : String?
    let vEF : String?
    let vND : String?
    let vUV : String?
    let wST : String?
    let xAF : String?
    let xAG : String?
    let xAU : String?
    let xCD : String?
    let xDR : String?
    let xOF : String?
    let xPF : String?
    let yER : String?
    let zAR : String?
    let zMK : String?
    let zMW : String?
    let zWL : String?

    enum CodingKeys: String, CodingKey {

        case aED = "AED"
        case aFN = "AFN"
        case aLL = "ALL"
        case aMD = "AMD"
        case aNG = "ANG"
        case aOA = "AOA"
        case aRS = "ARS"
        case aUD = "AUD"
        case aWG = "AWG"
        case aZN = "AZN"
        case bAM = "BAM"
        case bBD = "BBD"
        case bDT = "BDT"
        case bGN = "BGN"
        case bHD = "BHD"
        case bIF = "BIF"
        case bMD = "BMD"
        case bND = "BND"
        case bOB = "BOB"
        case bRL = "BRL"
        case bSD = "BSD"
        case bTC = "BTC"
        case bTN = "BTN"
        case bWP = "BWP"
        case bYN = "BYN"
        case bYR = "BYR"
        case bZD = "BZD"
        case cAD = "CAD"
        case cDF = "CDF"
        case cHF = "CHF"
        case cLF = "CLF"
        case cLP = "CLP"
        case cNY = "CNY"
        case cOP = "COP"
        case cRC = "CRC"
        case cUC = "CUC"
        case cUP = "CUP"
        case cVE = "CVE"
        case cZK = "CZK"
        case dJF = "DJF"
        case dKK = "DKK"
        case dOP = "DOP"
        case dZD = "DZD"
        case eGP = "EGP"
        case eRN = "ERN"
        case eTB = "ETB"
        case eUR = "EUR"
        case fJD = "FJD"
        case fKP = "FKP"
        case gBP = "GBP"
        case gEL = "GEL"
        case gGP = "GGP"
        case gHS = "GHS"
        case gIP = "GIP"
        case gMD = "GMD"
        case gNF = "GNF"
        case gTQ = "GTQ"
        case gYD = "GYD"
        case hKD = "HKD"
        case hNL = "HNL"
        case hRK = "HRK"
        case hTG = "HTG"
        case hUF = "HUF"
        case iDR = "IDR"
        case iLS = "ILS"
        case iMP = "IMP"
        case iNR = "INR"
        case iQD = "IQD"
        case iRR = "IRR"
        case iSK = "ISK"
        case jEP = "JEP"
        case jMD = "JMD"
        case jOD = "JOD"
        case jPY = "JPY"
        case kES = "KES"
        case kGS = "KGS"
        case kHR = "KHR"
        case kMF = "KMF"
        case kPW = "KPW"
        case kRW = "KRW"
        case kWD = "KWD"
        case kYD = "KYD"
        case kZT = "KZT"
        case lAK = "LAK"
        case lBP = "LBP"
        case lKR = "LKR"
        case lRD = "LRD"
        case lSL = "LSL"
        case lTL = "LTL"
        case lVL = "LVL"
        case lYD = "LYD"
        case mAD = "MAD"
        case mDL = "MDL"
        case mGA = "MGA"
        case mKD = "MKD"
        case mMK = "MMK"
        case mNT = "MNT"
        case mOP = "MOP"
        case mRO = "MRO"
        case mUR = "MUR"
        case mVR = "MVR"
        case mWK = "MWK"
        case mXN = "MXN"
        case mYR = "MYR"
        case mZN = "MZN"
        case nAD = "NAD"
        case nGN = "NGN"
        case nIO = "NIO"
        case nOK = "NOK"
        case nPR = "NPR"
        case nZD = "NZD"
        case oMR = "OMR"
        case pAB = "PAB"
        case pEN = "PEN"
        case pGK = "PGK"
        case pHP = "PHP"
        case pKR = "PKR"
        case pLN = "PLN"
        case pYG = "PYG"
        case qAR = "QAR"
        case rON = "RON"
        case rSD = "RSD"
        case rUB = "RUB"
        case rWF = "RWF"
        case sAR = "SAR"
        case sBD = "SBD"
        case sCR = "SCR"
        case sDG = "SDG"
        case sEK = "SEK"
        case sGD = "SGD"
        case sHP = "SHP"
        case sLL = "SLL"
        case sOS = "SOS"
        case sRD = "SRD"
        case sTD = "STD"
        case sVC = "SVC"
        case sYP = "SYP"
        case sZL = "SZL"
        case tHB = "THB"
        case tJS = "TJS"
        case tMT = "TMT"
        case tND = "TND"
        case tOP = "TOP"
        case tRY = "TRY"
        case tTD = "TTD"
        case tWD = "TWD"
        case tZS = "TZS"
        case uAH = "UAH"
        case uGX = "UGX"
        case uSD = "USD"
        case uYU = "UYU"
        case uZS = "UZS"
        case vEF = "VEF"
        case vND = "VND"
        case vUV = "VUV"
        case wST = "WST"
        case xAF = "XAF"
        case xAG = "XAG"
        case xAU = "XAU"
        case xCD = "XCD"
        case xDR = "XDR"
        case xOF = "XOF"
        case xPF = "XPF"
        case yER = "YER"
        case zAR = "ZAR"
        case zMK = "ZMK"
        case zMW = "ZMW"
        case zWL = "ZWL"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aED = try values.decodeIfPresent(String.self, forKey: .aED)
        aFN = try values.decodeIfPresent(String.self, forKey: .aFN)
        aLL = try values.decodeIfPresent(String.self, forKey: .aLL)
        aMD = try values.decodeIfPresent(String.self, forKey: .aMD)
        aNG = try values.decodeIfPresent(String.self, forKey: .aNG)
        aOA = try values.decodeIfPresent(String.self, forKey: .aOA)
        aRS = try values.decodeIfPresent(String.self, forKey: .aRS)
        aUD = try values.decodeIfPresent(String.self, forKey: .aUD)
        aWG = try values.decodeIfPresent(String.self, forKey: .aWG)
        aZN = try values.decodeIfPresent(String.self, forKey: .aZN)
        bAM = try values.decodeIfPresent(String.self, forKey: .bAM)
        bBD = try values.decodeIfPresent(String.self, forKey: .bBD)
        bDT = try values.decodeIfPresent(String.self, forKey: .bDT)
        bGN = try values.decodeIfPresent(String.self, forKey: .bGN)
        bHD = try values.decodeIfPresent(String.self, forKey: .bHD)
        bIF = try values.decodeIfPresent(String.self, forKey: .bIF)
        bMD = try values.decodeIfPresent(String.self, forKey: .bMD)
        bND = try values.decodeIfPresent(String.self, forKey: .bND)
        bOB = try values.decodeIfPresent(String.self, forKey: .bOB)
        bRL = try values.decodeIfPresent(String.self, forKey: .bRL)
        bSD = try values.decodeIfPresent(String.self, forKey: .bSD)
        bTC = try values.decodeIfPresent(String.self, forKey: .bTC)
        bTN = try values.decodeIfPresent(String.self, forKey: .bTN)
        bWP = try values.decodeIfPresent(String.self, forKey: .bWP)
        bYN = try values.decodeIfPresent(String.self, forKey: .bYN)
        bYR = try values.decodeIfPresent(String.self, forKey: .bYR)
        bZD = try values.decodeIfPresent(String.self, forKey: .bZD)
        cAD = try values.decodeIfPresent(String.self, forKey: .cAD)
        cDF = try values.decodeIfPresent(String.self, forKey: .cDF)
        cHF = try values.decodeIfPresent(String.self, forKey: .cHF)
        cLF = try values.decodeIfPresent(String.self, forKey: .cLF)
        cLP = try values.decodeIfPresent(String.self, forKey: .cLP)
        cNY = try values.decodeIfPresent(String.self, forKey: .cNY)
        cOP = try values.decodeIfPresent(String.self, forKey: .cOP)
        cRC = try values.decodeIfPresent(String.self, forKey: .cRC)
        cUC = try values.decodeIfPresent(String.self, forKey: .cUC)
        cUP = try values.decodeIfPresent(String.self, forKey: .cUP)
        cVE = try values.decodeIfPresent(String.self, forKey: .cVE)
        cZK = try values.decodeIfPresent(String.self, forKey: .cZK)
        dJF = try values.decodeIfPresent(String.self, forKey: .dJF)
        dKK = try values.decodeIfPresent(String.self, forKey: .dKK)
        dOP = try values.decodeIfPresent(String.self, forKey: .dOP)
        dZD = try values.decodeIfPresent(String.self, forKey: .dZD)
        eGP = try values.decodeIfPresent(String.self, forKey: .eGP)
        eRN = try values.decodeIfPresent(String.self, forKey: .eRN)
        eTB = try values.decodeIfPresent(String.self, forKey: .eTB)
        eUR = try values.decodeIfPresent(String.self, forKey: .eUR)
        fJD = try values.decodeIfPresent(String.self, forKey: .fJD)
        fKP = try values.decodeIfPresent(String.self, forKey: .fKP)
        gBP = try values.decodeIfPresent(String.self, forKey: .gBP)
        gEL = try values.decodeIfPresent(String.self, forKey: .gEL)
        gGP = try values.decodeIfPresent(String.self, forKey: .gGP)
        gHS = try values.decodeIfPresent(String.self, forKey: .gHS)
        gIP = try values.decodeIfPresent(String.self, forKey: .gIP)
        gMD = try values.decodeIfPresent(String.self, forKey: .gMD)
        gNF = try values.decodeIfPresent(String.self, forKey: .gNF)
        gTQ = try values.decodeIfPresent(String.self, forKey: .gTQ)
        gYD = try values.decodeIfPresent(String.self, forKey: .gYD)
        hKD = try values.decodeIfPresent(String.self, forKey: .hKD)
        hNL = try values.decodeIfPresent(String.self, forKey: .hNL)
        hRK = try values.decodeIfPresent(String.self, forKey: .hRK)
        hTG = try values.decodeIfPresent(String.self, forKey: .hTG)
        hUF = try values.decodeIfPresent(String.self, forKey: .hUF)
        iDR = try values.decodeIfPresent(String.self, forKey: .iDR)
        iLS = try values.decodeIfPresent(String.self, forKey: .iLS)
        iMP = try values.decodeIfPresent(String.self, forKey: .iMP)
        iNR = try values.decodeIfPresent(String.self, forKey: .iNR)
        iQD = try values.decodeIfPresent(String.self, forKey: .iQD)
        iRR = try values.decodeIfPresent(String.self, forKey: .iRR)
        iSK = try values.decodeIfPresent(String.self, forKey: .iSK)
        jEP = try values.decodeIfPresent(String.self, forKey: .jEP)
        jMD = try values.decodeIfPresent(String.self, forKey: .jMD)
        jOD = try values.decodeIfPresent(String.self, forKey: .jOD)
        jPY = try values.decodeIfPresent(String.self, forKey: .jPY)
        kES = try values.decodeIfPresent(String.self, forKey: .kES)
        kGS = try values.decodeIfPresent(String.self, forKey: .kGS)
        kHR = try values.decodeIfPresent(String.self, forKey: .kHR)
        kMF = try values.decodeIfPresent(String.self, forKey: .kMF)
        kPW = try values.decodeIfPresent(String.self, forKey: .kPW)
        kRW = try values.decodeIfPresent(String.self, forKey: .kRW)
        kWD = try values.decodeIfPresent(String.self, forKey: .kWD)
        kYD = try values.decodeIfPresent(String.self, forKey: .kYD)
        kZT = try values.decodeIfPresent(String.self, forKey: .kZT)
        lAK = try values.decodeIfPresent(String.self, forKey: .lAK)
        lBP = try values.decodeIfPresent(String.self, forKey: .lBP)
        lKR = try values.decodeIfPresent(String.self, forKey: .lKR)
        lRD = try values.decodeIfPresent(String.self, forKey: .lRD)
        lSL = try values.decodeIfPresent(String.self, forKey: .lSL)
        lTL = try values.decodeIfPresent(String.self, forKey: .lTL)
        lVL = try values.decodeIfPresent(String.self, forKey: .lVL)
        lYD = try values.decodeIfPresent(String.self, forKey: .lYD)
        mAD = try values.decodeIfPresent(String.self, forKey: .mAD)
        mDL = try values.decodeIfPresent(String.self, forKey: .mDL)
        mGA = try values.decodeIfPresent(String.self, forKey: .mGA)
        mKD = try values.decodeIfPresent(String.self, forKey: .mKD)
        mMK = try values.decodeIfPresent(String.self, forKey: .mMK)
        mNT = try values.decodeIfPresent(String.self, forKey: .mNT)
        mOP = try values.decodeIfPresent(String.self, forKey: .mOP)
        mRO = try values.decodeIfPresent(String.self, forKey: .mRO)
        mUR = try values.decodeIfPresent(String.self, forKey: .mUR)
        mVR = try values.decodeIfPresent(String.self, forKey: .mVR)
        mWK = try values.decodeIfPresent(String.self, forKey: .mWK)
        mXN = try values.decodeIfPresent(String.self, forKey: .mXN)
        mYR = try values.decodeIfPresent(String.self, forKey: .mYR)
        mZN = try values.decodeIfPresent(String.self, forKey: .mZN)
        nAD = try values.decodeIfPresent(String.self, forKey: .nAD)
        nGN = try values.decodeIfPresent(String.self, forKey: .nGN)
        nIO = try values.decodeIfPresent(String.self, forKey: .nIO)
        nOK = try values.decodeIfPresent(String.self, forKey: .nOK)
        nPR = try values.decodeIfPresent(String.self, forKey: .nPR)
        nZD = try values.decodeIfPresent(String.self, forKey: .nZD)
        oMR = try values.decodeIfPresent(String.self, forKey: .oMR)
        pAB = try values.decodeIfPresent(String.self, forKey: .pAB)
        pEN = try values.decodeIfPresent(String.self, forKey: .pEN)
        pGK = try values.decodeIfPresent(String.self, forKey: .pGK)
        pHP = try values.decodeIfPresent(String.self, forKey: .pHP)
        pKR = try values.decodeIfPresent(String.self, forKey: .pKR)
        pLN = try values.decodeIfPresent(String.self, forKey: .pLN)
        pYG = try values.decodeIfPresent(String.self, forKey: .pYG)
        qAR = try values.decodeIfPresent(String.self, forKey: .qAR)
        rON = try values.decodeIfPresent(String.self, forKey: .rON)
        rSD = try values.decodeIfPresent(String.self, forKey: .rSD)
        rUB = try values.decodeIfPresent(String.self, forKey: .rUB)
        rWF = try values.decodeIfPresent(String.self, forKey: .rWF)
        sAR = try values.decodeIfPresent(String.self, forKey: .sAR)
        sBD = try values.decodeIfPresent(String.self, forKey: .sBD)
        sCR = try values.decodeIfPresent(String.self, forKey: .sCR)
        sDG = try values.decodeIfPresent(String.self, forKey: .sDG)
        sEK = try values.decodeIfPresent(String.self, forKey: .sEK)
        sGD = try values.decodeIfPresent(String.self, forKey: .sGD)
        sHP = try values.decodeIfPresent(String.self, forKey: .sHP)
        sLL = try values.decodeIfPresent(String.self, forKey: .sLL)
        sOS = try values.decodeIfPresent(String.self, forKey: .sOS)
        sRD = try values.decodeIfPresent(String.self, forKey: .sRD)
        sTD = try values.decodeIfPresent(String.self, forKey: .sTD)
        sVC = try values.decodeIfPresent(String.self, forKey: .sVC)
        sYP = try values.decodeIfPresent(String.self, forKey: .sYP)
        sZL = try values.decodeIfPresent(String.self, forKey: .sZL)
        tHB = try values.decodeIfPresent(String.self, forKey: .tHB)
        tJS = try values.decodeIfPresent(String.self, forKey: .tJS)
        tMT = try values.decodeIfPresent(String.self, forKey: .tMT)
        tND = try values.decodeIfPresent(String.self, forKey: .tND)
        tOP = try values.decodeIfPresent(String.self, forKey: .tOP)
        tRY = try values.decodeIfPresent(String.self, forKey: .tRY)
        tTD = try values.decodeIfPresent(String.self, forKey: .tTD)
        tWD = try values.decodeIfPresent(String.self, forKey: .tWD)
        tZS = try values.decodeIfPresent(String.self, forKey: .tZS)
        uAH = try values.decodeIfPresent(String.self, forKey: .uAH)
        uGX = try values.decodeIfPresent(String.self, forKey: .uGX)
        uSD = try values.decodeIfPresent(String.self, forKey: .uSD)
        uYU = try values.decodeIfPresent(String.self, forKey: .uYU)
        uZS = try values.decodeIfPresent(String.self, forKey: .uZS)
        vEF = try values.decodeIfPresent(String.self, forKey: .vEF)
        vND = try values.decodeIfPresent(String.self, forKey: .vND)
        vUV = try values.decodeIfPresent(String.self, forKey: .vUV)
        wST = try values.decodeIfPresent(String.self, forKey: .wST)
        xAF = try values.decodeIfPresent(String.self, forKey: .xAF)
        xAG = try values.decodeIfPresent(String.self, forKey: .xAG)
        xAU = try values.decodeIfPresent(String.self, forKey: .xAU)
        xCD = try values.decodeIfPresent(String.self, forKey: .xCD)
        xDR = try values.decodeIfPresent(String.self, forKey: .xDR)
        xOF = try values.decodeIfPresent(String.self, forKey: .xOF)
        xPF = try values.decodeIfPresent(String.self, forKey: .xPF)
        yER = try values.decodeIfPresent(String.self, forKey: .yER)
        zAR = try values.decodeIfPresent(String.self, forKey: .zAR)
        zMK = try values.decodeIfPresent(String.self, forKey: .zMK)
        zMW = try values.decodeIfPresent(String.self, forKey: .zMW)
        zWL = try values.decodeIfPresent(String.self, forKey: .zWL)
    }

}
