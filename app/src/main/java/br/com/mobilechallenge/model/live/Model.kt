package br.com.mobilechallenge.model.live

import java.text.MessageFormat

import br.com.mobilechallenge.model.PriceDAO
import br.com.mobilechallenge.model.bean.ListBean
import br.com.mobilechallenge.model.bean.LiveBean
import br.com.mobilechallenge.model.enums.Endpoints

import org.json.JSONObject

import com.android.volley.RequestQueue
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley

import br.com.mobilechallenge.presenter.live.MVP
import br.com.mobilechallenge.utils.Constantes
import br.com.mobilechallenge.utils.Utils

class Model(private val presenter: MVP.Presenter): MVP.Model {
    private lateinit var requestQueue: RequestQueue

    override fun retrieveData(codeFrom: ListBean?, codeTo: ListBean?, amount: Double) {
        presenter.showProgressBar(true)
        if (Utils.isInternetConnect(presenter.context)) {
            val currencies = "${codeFrom?.code},${codeTo?.code}"
            val wsEndpoint: String = Endpoints.LIVE.endpoint()
            val uri: String = MessageFormat.format(wsEndpoint, Constantes.accessKey, currencies)
            val baseUrl: String = Constantes.baseURL + uri
            val requestQueue: RequestQueue = Volley.newRequestQueue(presenter.context)

            val request = JsonObjectRequest(
                Request.Method.GET,
                baseUrl,
                null,
                Response.Listener {
                    val quotes = JSONObject(it.getString("quotes"))
                    val valueFrom: Double = quotes.getDouble("USD${codeFrom?.code}")
                    val valueTo: Double = quotes.getDouble("USD${codeTo?.code}")
                    val calcFrom: Double = amount / valueFrom
                    val calcTo: Double = calcFrom * valueTo

                    saveLive(0, codeFrom?.id, codeFrom?.code, valueFrom)
                    saveLive(0, codeTo?.id, codeTo?.code, valueTo)

                    presenter.apply {
                        resultCalc(calcTo)
                        showProgressBar(false)
                    }
                },
                null
            )

            requestQueue.add(request)
        }
        else {
            var itemFrom: LiveBean? = null
            var itemTo: LiveBean?  = null

            PriceDAO(presenter.context)
                .apply {
                    itemFrom = get(codeFrom?.id)
                    itemTo = get(codeTo?.id)
                    close()
                }

            val calcFrom: Double = amount * itemFrom!!.price
            val calcTo: Double   = calcFrom * itemTo!!.price

            presenter.apply {
                resultCalc(calcTo)
                showProgressBar(false)
            }
        }
    }

    private fun saveLive(id: Int, idCurrencies: Int?, code: String?, price: Double) {
        val bean = LiveBean(id, idCurrencies, code, price)
        PriceDAO(presenter.context)
            .apply {
                save(bean)
                close()
            }
    }
}