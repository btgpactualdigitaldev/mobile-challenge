package com.matheus.conversordemoedas.presenter

import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.matheus.conversordemoedas.BuildConfig
import com.matheus.conversordemoedas.contract.CurrencyListContract
import com.matheus.conversordemoedas.model.CurrencyJson
import com.matheus.conversordemoedas.model.CurrencyResult
import java.lang.reflect.Type

class CurrencyListPresenter : CurrencyListContract.Presenter {

    private var view : CurrencyListContract.View? = null

    override fun setView(view: CurrencyListContract.View) {
        this.view = view
    }

    override fun getList() {
        view?.showProgress()
        val queue = Volley.newRequestQueue(view?.getContext())
        val url = BuildConfig.BASE_URL+"list?access_key="+BuildConfig.ACCESS_KEY+"&format=1"

        val jsonObjectRequest = JsonObjectRequest(Request.Method.GET, url, null,
            { response ->
                val stringJson = response.toString()
                val result = Gson().fromJson(stringJson, CurrencyJson::class.java)
                if (!result.success){
                    view?.showMsgError("Houve um problema ao buscar os dados, tente novamente mais tarde.")
                } else {
                    val currencies = Gson().toJson(result.currencies)
                    var currenciesResultList: ArrayList<CurrencyResult> = arrayListOf()

                    val type: Type = object : TypeToken<Map<String?, Any?>?>() {}.type
                    val map: Map<String, Any> = Gson().fromJson(currencies, type)
                    map.forEach { (k: String, v: Any) ->
                        if (v is Map<*, *>) {

                        } else {
                            currenciesResultList.add(CurrencyResult(k, v.toString()))
                        }
                    }
                    if (currenciesResultList.size > 0) {
                        view?.hideProgress()
                        view?.loadRecycler(currenciesResultList)
                    } else {
                        view?.hideProgress()
                        view?.showMsgError("Sem moedas disponíveis!")
                    }
                }
            },
            { error ->
                view?.hideProgress()
                view?.showMsgError("Falha na requisição, tente novamente mais tarde.")
            }
        )
        queue.add(jsonObjectRequest)
    }

    override fun onDestroy() {
        this.view = null
    }

}