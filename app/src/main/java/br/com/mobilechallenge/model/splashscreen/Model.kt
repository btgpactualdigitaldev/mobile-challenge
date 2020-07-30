package br.com.mobilechallenge.model.splashscreen

import br.com.mobilechallenge.model.CurrenciesDAO
import com.google.gson.Gson

import java.text.MessageFormat

import com.android.volley.RequestQueue
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley

import br.com.mobilechallenge.presenter.splashscreen.MVP
import br.com.mobilechallenge.utils.Constantes
import br.com.mobilechallenge.utils.Utils
import br.com.mobilechallenge.model.DataBase
import br.com.mobilechallenge.model.enums.Endpoints
import br.com.mobilechallenge.model.gson.ListCurrency
import br.com.mobilechallenge.model.bean.ListBean

class Model(private val presenter: MVP.Presenter): MVP.Model {
    override fun retriveData() {
        val config: String? = Utils.getStringConfig(presenter.context, "list_load")
        if (!config.equals("Y")) {
            DataBase.instance.create(presenter.context)

            val wsEndpoint: String = Endpoints.LIST.endpoint()
            val uri: String = MessageFormat.format(wsEndpoint, Constantes.accessKey)
            val baseUrl: String = Constantes.baseURL + uri
            val requestQueue: RequestQueue = Volley.newRequestQueue(presenter.context)

            val request = StringRequest(
                Request.Method.GET,
                baseUrl,
                Response.Listener {
                    val data: ListCurrency = Gson().fromJson(it.trim(), ListCurrency::class.java)
                    val repository =
                        CurrenciesDAO(presenter.context)
                        repository.truncate()

                    data.currencies.apply {
                        repository.save(ListBean(1, "AED", aED))
                        repository.save(ListBean(2, "AFN", aFN))
                        repository.save(ListBean(3, "ALL", aLL))
                        repository.save(ListBean(4, "AMD", aMD))
                        repository.save(ListBean(5, "ANG", aNG))
                        repository.save(ListBean(6, "AOA", aOA))
                        repository.save(ListBean(7, "ARS", aRS))
                        repository.save(ListBean(8, "AUD", aUD))
                        repository.save(ListBean(9, "AWG", aWG))
                        repository.save(ListBean(10, "AZN", aZN))
                        repository.save(ListBean(11, "BAM", bAM))
                        repository.save(ListBean(12, "BBD", bBD))
                        repository.save(ListBean(13, "BDT", bDT))
                        repository.save(ListBean(14, "BGN", bGN))
                        repository.save(ListBean(15, "BHD", bHD))
                        repository.save(ListBean(16, "BIF", bIF))
                        repository.save(ListBean(17, "BMD", bMD))
                        repository.save(ListBean(18, "BND", bND))
                        repository.save(ListBean(19, "BOB", bOB))
                        repository.save(ListBean(20, "BRL", bRL))
                        repository.save(ListBean(21, "BSD", bSD))
                        repository.save(ListBean(22, "BTC", bTC))
                        repository.save(ListBean(23, "BTN", bTN))
                        repository.save(ListBean(24, "BWP", bWP))
                        repository.save(ListBean(25, "BYN", bYN))
                        repository.save(ListBean(26, "BYR", bYR))
                        repository.save(ListBean(27, "BZD", bZD))
                        repository.save(ListBean(28, "CAD", cAD))
                        repository.save(ListBean(29, "CDF", cDF))
                        repository.save(ListBean(30, "CHF", cHF))
                        repository.save(ListBean(31, "CLF", cLF))
                        repository.save(ListBean(32, "CLP", cLP))
                        repository.save(ListBean(33, "CNY", cNY))
                        repository.save(ListBean(34, "COP", cOP))
                        repository.save(ListBean(35, "CRC", cRC))
                        repository.save(ListBean(36, "CUC", cUC))
                        repository.save(ListBean(37, "CUP", cUP))
                        repository.save(ListBean(38, "CVE", cVE))
                        repository.save(ListBean(39, "CZK", cZK))
                        repository.save(ListBean(40, "DJF", dJF))
                        repository.save(ListBean(41, "DKK", dKK))
                        repository.save(ListBean(42, "DOP", dOP))
                        repository.save(ListBean(43, "DZD", dZD))
                        repository.save(ListBean(44, "EGP", eGP))
                        repository.save(ListBean(45, "ERN", eRN))
                        repository.save(ListBean(46, "ETB", eTB))
                        repository.save(ListBean(47, "EUR", eUR))
                        repository.save(ListBean(48, "FJD", fJD))
                        repository.save(ListBean(49, "FKP", fKP))
                        repository.save(ListBean(50, "GBP", gBP))
                        repository.save(ListBean(51, "GEL", gEL))
                        repository.save(ListBean(52, "GGP", gGP))
                        repository.save(ListBean(53, "GHS", gHS))
                        repository.save(ListBean(54, "GIP", gIP))
                        repository.save(ListBean(55, "GMD", gMD))
                        repository.save(ListBean(56, "GNF", gNF))
                        repository.save(ListBean(57, "GTQ", gTQ))
                        repository.save(ListBean(58, "GYD", gYD))
                        repository.save(ListBean(59, "HKD", hKD))
                        repository.save(ListBean(60, "HNL", hNL))
                        repository.save(ListBean(61, "HRK", hRK))
                        repository.save(ListBean(62, "HTG", hTG))
                        repository.save(ListBean(63, "HUF", hUF))
                        repository.save(ListBean(64, "IDR", iDR))
                        repository.save(ListBean(65, "ILS", iLS))
                        repository.save(ListBean(66, "IMP", iMP))
                        repository.save(ListBean(67, "INR", iNR))
                        repository.save(ListBean(68, "IQD", iQD))
                        repository.save(ListBean(69, "IRR", iRR))
                        repository.save(ListBean(70, "ISK", iSK))
                        repository.save(ListBean(71, "JEP", jEP))
                        repository.save(ListBean(72, "JMD", jMD))
                        repository.save(ListBean(73, "JOD", jOD))
                        repository.save(ListBean(74, "JPY", jPY))
                        repository.save(ListBean(75, "KES", kES))
                        repository.save(ListBean(76, "KGS", kGS))
                        repository.save(ListBean(77, "KHR", kHR))
                        repository.save(ListBean(78, "KMF", kMF))
                        repository.save(ListBean(79, "KPW", kPW))
                        repository.save(ListBean(80, "KRW", kRW))
                        repository.save(ListBean(81, "KWD", kWD))
                        repository.save(ListBean(82, "KYD", kYD))
                        repository.save(ListBean(83, "KZT", kZT))
                        repository.save(ListBean(84, "LAK", lAK))
                        repository.save(ListBean(85, "LBP", lBP))
                        repository.save(ListBean(86, "LKR", lKR))
                        repository.save(ListBean(87, "LRD", lRD))
                        repository.save(ListBean(88, "LSL", lSL))
                        repository.save(ListBean(89, "LTL", lTL))
                        repository.save(ListBean(90, "LVL", lVL))
                        repository.save(ListBean(91, "LYD", lYD))
                        repository.save(ListBean(92, "MAD", mAD))
                        repository.save(ListBean(93, "MDL", mDL))
                        repository.save(ListBean(94, "MGA", mGA))
                        repository.save(ListBean(95, "MKD", mKD))
                        repository.save(ListBean(96, "MMK", mMK))
                        repository.save(ListBean(97, "MNT", mNT))
                        repository.save(ListBean(98, "MOP", mOP))
                        repository.save(ListBean(99, "MRO", mRO))
                        repository.save(ListBean(100, "MUR", mUR))
                        repository.save(ListBean(101, "MVR", mVR))
                        repository.save(ListBean(102, "MWK", mWK))
                        repository.save(ListBean(103, "MXN", mXN))
                        repository.save(ListBean(104, "MYR", mYR))
                        repository.save(ListBean(105, "MZN", mZN))
                        repository.save(ListBean(106, "NAD", nAD))
                        repository.save(ListBean(107, "NGN", nGN))
                        repository.save(ListBean(108, "NIO", nIO))
                        repository.save(ListBean(109, "NOK", nOK))
                        repository.save(ListBean(110, "NPR", nPR))
                        repository.save(ListBean(111, "NZD", nZD))
                        repository.save(ListBean(112, "OMR", oMR))
                        repository.save(ListBean(113, "PAB", pAB))
                        repository.save(ListBean(114, "PEN", pEN))
                        repository.save(ListBean(115, "PGK", pGK))
                        repository.save(ListBean(116, "PHP", pHP))
                        repository.save(ListBean(117, "PKR", pKR))
                        repository.save(ListBean(118, "PLN", pLN))
                        repository.save(ListBean(119, "PYG", pYG))
                        repository.save(ListBean(120, "QAR", qAR))
                        repository.save(ListBean(121, "RON", rON))
                        repository.save(ListBean(122, "RSD", rSD))
                        repository.save(ListBean(123, "RUB", rUB))
                        repository.save(ListBean(124, "RWF", rWF))
                        repository.save(ListBean(125, "SAR", sAR))
                        repository.save(ListBean(126, "SBD", sBD))
                        repository.save(ListBean(127, "SCR", sCR))
                        repository.save(ListBean(128, "SDG", sDG))
                        repository.save(ListBean(129, "SEK", sEK))
                        repository.save(ListBean(130, "SGD", sGD))
                        repository.save(ListBean(131, "SHP", sHP))
                        repository.save(ListBean(132, "SLL", sLL))
                        repository.save(ListBean(133, "SOS", sOS))
                        repository.save(ListBean(134, "SRD", sRD))
                        repository.save(ListBean(135, "STD", sTD))
                        repository.save(ListBean(136, "SVC", sVC))
                        repository.save(ListBean(137, "SYP", sYP))
                        repository.save(ListBean(138, "SZL", sZL))
                        repository.save(ListBean(139, "THB", tHB))
                        repository.save(ListBean(140, "TJS", tJS))
                        repository.save(ListBean(141, "TMT", tMT))
                        repository.save(ListBean(142, "TND", tND))
                        repository.save(ListBean(143, "TOP", tOP))
                        repository.save(ListBean(144, "TRY", tRY))
                        repository.save(ListBean(145, "TTD", tTD))
                        repository.save(ListBean(146, "TWD", tWD))
                        repository.save(ListBean(147, "TZS", tZS))
                        repository.save(ListBean(148, "UAH", uAH))
                        repository.save(ListBean(149, "UGX", uGX))
                        repository.save(ListBean(150, "USD", uSD))
                        repository.save(ListBean(151, "UYU", uYU))
                        repository.save(ListBean(152, "UZS", uZS))
                        repository.save(ListBean(153, "VEF", vEF))
                        repository.save(ListBean(154, "VND", vND))
                        repository.save(ListBean(155, "VUV", vUV))
                        repository.save(ListBean(156, "WST", wST))
                        repository.save(ListBean(157, "XAF", xAF))
                        repository.save(ListBean(158, "XAG", xAG))
                        repository.save(ListBean(159, "XAU", xAU))
                        repository.save(ListBean(160, "XCD", xCD))
                        repository.save(ListBean(161, "XDR", xDR))
                        repository.save(ListBean(162, "XOF", xOF))
                        repository.save(ListBean(163, "XPF", xPF))
                        repository.save(ListBean(164, "YER", yER))
                        repository.save(ListBean(165, "ZAR", zAR))
                        repository.save(ListBean(166, "ZMK", zMK))
                        repository.save(ListBean(167, "ZMW", zMW))
                    }

                    repository.close()

                    Utils.setStringConfig(presenter.context, "list_load", "Y")

                    presenter.loadData()
                },
                Response.ErrorListener {}
            )

            requestQueue.add(request)
        }
        else {
            presenter.loadData()
        }
    }
}