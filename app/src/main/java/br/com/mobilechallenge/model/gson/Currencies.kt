package br.com.mobilechallenge.model.gson

import android.os.Parcelable

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

import kotlinx.android.parcel.Parcelize

@Parcelize
data class Currencies(
    @SerializedName("AED")
    @Expose
    var aED: String,

    @SerializedName("AFN")
    @Expose
    var aFN: String,

    @SerializedName("ALL")
    @Expose
    var aLL: String,

    @SerializedName("AMD")
    @Expose
    var aMD: String,

    @SerializedName("ANG")
    @Expose
    var aNG: String,

    @SerializedName("AOA")
    @Expose
    var aOA: String,

    @SerializedName("ARS")
    @Expose
    var aRS: String,

    @SerializedName("AUD")
    @Expose
    var aUD: String,

    @SerializedName("AWG")
    @Expose
    var aWG: String,

    @SerializedName("AZN")
    @Expose
    var aZN: String,

    @SerializedName("BAM")
    @Expose
    var bAM: String,

    @SerializedName("BBD")
    @Expose
    var bBD: String,

    @SerializedName("BDT")
    @Expose
    var bDT: String,

    @SerializedName("BGN")
    @Expose
    var bGN: String,

    @SerializedName("BHD")
    @Expose
    var bHD: String,

    @SerializedName("BIF")
    @Expose
    var bIF: String,

    @SerializedName("BMD")
    @Expose
    var bMD: String,

    @SerializedName("BND")
    @Expose
    var bND: String,

    @SerializedName("BOB")
    @Expose
    var bOB: String,

    @SerializedName("BRL")
    @Expose
    var bRL: String,

    @SerializedName("BSD")
    @Expose
    var bSD: String,

    @SerializedName("BTC")
    @Expose
    var bTC: String,

    @SerializedName("BTN")
    @Expose
    var bTN: String,

    @SerializedName("BWP")
    @Expose
    var bWP: String,

    @SerializedName("BYN")
    @Expose
    var bYN: String,

    @SerializedName("BYR")
    @Expose
    var bYR: String,

    @SerializedName("BZD")
    @Expose
    var bZD: String,

    @SerializedName("CAD")
    @Expose
    var cAD: String,

    @SerializedName("CDF")
    @Expose
    var cDF: String,

    @SerializedName("CHF")
    @Expose
    var cHF: String,

    @SerializedName("CLF")
    @Expose
    var cLF: String,

    @SerializedName("CLP")
    @Expose
    var cLP: String,

    @SerializedName("CNY")
    @Expose
    var cNY: String,

    @SerializedName("COP")
    @Expose
    var cOP: String,

    @SerializedName("CRC")
    @Expose
    var cRC: String,

    @SerializedName("CUC")
    @Expose
    var cUC: String,

    @SerializedName("CUP")
    @Expose
    var cUP: String,

    @SerializedName("CVE")
    @Expose
    var cVE: String,

    @SerializedName("CZK")
    @Expose
    var cZK: String,

    @SerializedName("DJF")
    @Expose
    var dJF: String,

    @SerializedName("DKK")
    @Expose
    var dKK: String,

    @SerializedName("DOP")
    @Expose
    var dOP: String,

    @SerializedName("DZD")
    @Expose
    var dZD: String,

    @SerializedName("EGP")
    @Expose
    var eGP: String,

    @SerializedName("ERN")
    @Expose
    var eRN: String,

    @SerializedName("ETB")
    @Expose
    var eTB: String,

    @SerializedName("EUR")
    @Expose
    var eUR: String,

    @SerializedName("FJD")
    @Expose
    var fJD: String,

    @SerializedName("FKP")
    @Expose
    var fKP: String,

    @SerializedName("GBP")
    @Expose
    var gBP: String,

    @SerializedName("GEL")
    @Expose
    var gEL: String,

    @SerializedName("GGP")
    @Expose
    var gGP: String,

    @SerializedName("GHS")
    @Expose
    var gHS: String,

    @SerializedName("GIP")
    @Expose
    var gIP: String,

    @SerializedName("GMD")
    @Expose
    var gMD: String,

    @SerializedName("GNF")
    @Expose
    var gNF: String,

    @SerializedName("GTQ")
    @Expose
    var gTQ: String,

    @SerializedName("GYD")
    @Expose
    var gYD: String,

    @SerializedName("HKD")
    @Expose
    var hKD: String,

    @SerializedName("HNL")
    @Expose
    var hNL: String,

    @SerializedName("HRK")
    @Expose
    var hRK: String,

    @SerializedName("HTG")
    @Expose
    var hTG: String,

    @SerializedName("HUF")
    @Expose
    var hUF: String,

    @SerializedName("IDR")
    @Expose
    var iDR: String,

    @SerializedName("ILS")
    @Expose
    var iLS: String,

    @SerializedName("IMP")
    @Expose
    var iMP: String,

    @SerializedName("INR")
    @Expose
    var iNR: String,

    @SerializedName("IQD")
    @Expose
    var iQD: String,

    @SerializedName("IRR")
    @Expose
    var iRR: String,

    @SerializedName("ISK")
    @Expose
    var iSK: String,

    @SerializedName("JEP")
    @Expose
    var jEP: String,

    @SerializedName("JMD")
    @Expose
    var jMD: String,

    @SerializedName("JOD")
    @Expose
    var jOD: String,

    @SerializedName("JPY")
    @Expose
    var jPY: String,

    @SerializedName("KES")
    @Expose
    var kES: String,

    @SerializedName("KGS")
    @Expose
    var kGS: String,

    @SerializedName("KHR")
    @Expose
    var kHR: String,

    @SerializedName("KMF")
    @Expose
    var kMF: String,

    @SerializedName("KPW")
    @Expose
    var kPW: String,

    @SerializedName("KRW")
    @Expose
    var kRW: String,

    @SerializedName("KWD")
    @Expose
    var kWD: String,

    @SerializedName("KYD")
    @Expose
    var kYD: String,

    @SerializedName("KZT")
    @Expose
    var kZT: String,

    @SerializedName("LAK")
    @Expose
    var lAK: String,

    @SerializedName("LBP")
    @Expose
    var lBP: String,

    @SerializedName("LKR")
    @Expose
    var lKR: String,

    @SerializedName("LRD")
    @Expose
    var lRD: String,

    @SerializedName("LSL")
    @Expose
    var lSL: String,

    @SerializedName("LTL")
    @Expose
    var lTL: String,

    @SerializedName("LVL")
    @Expose
    var lVL: String,

    @SerializedName("LYD")
    @Expose
    var lYD: String,

    @SerializedName("MAD")
    @Expose
    var mAD: String,

    @SerializedName("MDL")
    @Expose
    var mDL: String,

    @SerializedName("MGA")
    @Expose
    var mGA: String,

    @SerializedName("MKD")
    @Expose
    var mKD: String,

    @SerializedName("MMK")
    @Expose
    var mMK: String,

    @SerializedName("MNT")
    @Expose
    var mNT: String,

    @SerializedName("MOP")
    @Expose
    var mOP: String,

    @SerializedName("MRO")
    @Expose
    var mRO: String,

    @SerializedName("MUR")
    @Expose
    var mUR: String,

    @SerializedName("MVR")
    @Expose
    var mVR: String,

    @SerializedName("MWK")
    @Expose
    var mWK: String,

    @SerializedName("MXN")
    @Expose
    var mXN: String,

    @SerializedName("MYR")
    @Expose
    var mYR: String,

    @SerializedName("MZN")
    @Expose
    var mZN: String,

    @SerializedName("NAD")
    @Expose
    var nAD: String,

    @SerializedName("NGN")
    @Expose
    var nGN: String,

    @SerializedName("NIO")
    @Expose
    var nIO: String,

    @SerializedName("NOK")
    @Expose
    var nOK: String,

    @SerializedName("NPR")
    @Expose
    var nPR: String,

    @SerializedName("NZD")
    @Expose
    var nZD: String,

    @SerializedName("OMR")
    @Expose
    var oMR: String,

    @SerializedName("PAB")
    @Expose
    var pAB: String,

    @SerializedName("PEN")
    @Expose
    var pEN: String,

    @SerializedName("PGK")
    @Expose
    var pGK: String,

    @SerializedName("PHP")
    @Expose
    var pHP: String,

    @SerializedName("PKR")
    @Expose
    var pKR: String,

    @SerializedName("PLN")
    @Expose
    var pLN: String,

    @SerializedName("PYG")
    @Expose
    var pYG: String,

    @SerializedName("QAR")
    @Expose
    var qAR: String,

    @SerializedName("RON")
    @Expose
    var rON: String,

    @SerializedName("RSD")
    @Expose
    var rSD: String,

    @SerializedName("RUB")
    @Expose
    var rUB: String,

    @SerializedName("RWF")
    @Expose
    var rWF: String,

    @SerializedName("SAR")
    @Expose
    var sAR: String,

    @SerializedName("SBD")
    @Expose
    var sBD: String,

    @SerializedName("SCR")
    @Expose
    var sCR: String,

    @SerializedName("SDG")
    @Expose
    var sDG: String,

    @SerializedName("SEK")
    @Expose
    var sEK: String,

    @SerializedName("SGD")
    @Expose
    var sGD: String,

    @SerializedName("SHP")
    @Expose
    var sHP: String,

    @SerializedName("SLL")
    @Expose
    var sLL: String,

    @SerializedName("SOS")
    @Expose
    var sOS: String,

    @SerializedName("SRD")
    @Expose
    var sRD: String,

    @SerializedName("STD")
    @Expose
    var sTD: String,

    @SerializedName("SVC")
    @Expose
    var sVC: String,

    @SerializedName("SYP")
    @Expose
    var sYP: String,

    @SerializedName("SZL")
    @Expose
    var sZL: String,

    @SerializedName("THB")
    @Expose
    var tHB: String,

    @SerializedName("TJS")
    @Expose
    var tJS: String,

    @SerializedName("TMT")
    @Expose
    var tMT: String,

    @SerializedName("TND")
    @Expose
    var tND: String,

    @SerializedName("TOP")
    @Expose
    var tOP: String,

    @SerializedName("TRY")
    @Expose
    var tRY: String,

    @SerializedName("TTD")
    @Expose
    var tTD: String,

    @SerializedName("TWD")
    @Expose
    var tWD: String,

    @SerializedName("TZS")
    @Expose
    var tZS: String,

    @SerializedName("UAH")
    @Expose
    var uAH: String,

    @SerializedName("UGX")
    @Expose
    var uGX: String,

    @SerializedName("USD")
    @Expose
    var uSD: String,

    @SerializedName("UYU")
    @Expose
    var uYU: String,

    @SerializedName("UZS")
    @Expose
    var uZS: String,

    @SerializedName("VEF")
    @Expose
    var vEF: String,

    @SerializedName("VND")
    @Expose
    var vND: String,

    @SerializedName("VUV")
    @Expose
    var vUV: String,

    @SerializedName("WST")
    @Expose
    var wST: String,

    @SerializedName("XAF")
    @Expose
    var xAF: String,

    @SerializedName("XAG")
    @Expose
    var xAG: String,

    @SerializedName("XAU")
    @Expose
    var xAU: String,

    @SerializedName("XCD")
    @Expose
    var xCD: String,

    @SerializedName("XDR")
    @Expose
    var xDR: String,

    @SerializedName("XOF")
    @Expose
    var xOF: String,

    @SerializedName("XPF")
    @Expose
    var xPF: String,

    @SerializedName("YER")
    @Expose
    var yER: String,

    @SerializedName("ZAR")
    @Expose
    var zAR: String,

    @SerializedName("ZMK")
    @Expose
    var zMK: String,

    @SerializedName("ZMW")
    @Expose
    var zMW: String,

    @SerializedName("ZWL")
    @Expose
    var zWL: String
) : Parcelable