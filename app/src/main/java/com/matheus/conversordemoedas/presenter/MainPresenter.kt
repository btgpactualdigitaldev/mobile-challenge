package com.matheus.conversordemoedas.presenter

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.matheus.conversordemoedas.BuildConfig
import com.matheus.conversordemoedas.contract.MainContract
import com.matheus.conversordemoedas.model.CurrencyLiveResult
import com.matheus.conversordemoedas.view.MainActivity
import java.lang.Exception
import java.lang.reflect.Type

class MainPresenter : MainContract.Presenter {

    private var view : MainContract.View? = null

    override fun setView(view: MainContract.View) {
        this.view = view
    }

    override fun convertCurrency(codeFrom: String, descriptionFrom: String, codeTo: String, descriptionTo: String) {
        view?.showProgress()
        val value = valueIsConvert()
        var valueFromConverted: Double = 0.0
        var valueFrom: Double = 0.0
        var valueTo: Double = 0.0
        if(!codeFrom.equals("USD") && !codeTo.equals("USD")){
            val queue = Volley.newRequestQueue(view?.getContext())
            val url = BuildConfig.BASE_URL+"live?access_key="+ BuildConfig.ACCESS_KEY+"&currencies=USD,"+codeFrom+","+codeTo+"&format=1"
            val jsonObjectRequest = JsonObjectRequest(Request.Method.GET, url, null,
                    { response ->
                        val stringJson = response.toString()
                        val result = Gson().fromJson(stringJson, CurrencyLiveResult::class.java)
                        if (!result.success){
                            view?.showMsgError("Houve um problema ao buscar os dados, tente novamente mais tarde.")
                        } else {
                            val currencies = Gson().toJson(result.quotes)
                            val type: Type = object : TypeToken<Map<String?, Any?>?>() {}.type
                            val map: Map<String, Any> = Gson().fromJson(currencies, type)
                            map.forEach { (k: String, v: Any) ->
                                if (v is Map<*, *>) {

                                } else {
                                    if (v.toString().toDouble() > 0) {
                                        if (k.equals("USD"+codeFrom)) {
                                            valueFromConverted = v.toString().toDouble()
                                            valueFrom = value / valueFromConverted
                                        } else if(k.equals("USD"+codeTo)){
                                            valueTo = v.toString().toDouble()
                                        }
                                    }
                                }
                            }
                            val result = valueFrom * valueTo
                            val result2Decimals = Math.round(result * 100) / 100.0
                            view?.hideProgress()
                            view?.setResult("Resultado: " + result2Decimals + " " + codeTo + " - " + descriptionTo)
                        }
                    },
                    { error ->
                        view?.hideProgress()
                        view?.showMsgError("Falha na requisição, tente novamente mais tarde.")
                    }
            )
            queue.add(jsonObjectRequest)
        } else {
            val queue = Volley.newRequestQueue(view?.getContext())
            val url = BuildConfig.BASE_URL+"live?access_key="+ BuildConfig.ACCESS_KEY+"&currencies="+codeFrom+","+codeTo+"&format=1"
            val jsonObjectRequest = JsonObjectRequest(Request.Method.GET, url, null,
                    { response ->
                        val stringJson = response.toString()
                        val result = Gson().fromJson(stringJson, CurrencyLiveResult::class.java)
                        if (!result.success){
                            view?.showMsgError("Houve um problema ao buscar os dados, tente novamente mais tarde.")
                        } else {
                            val currencies = Gson().toJson(result.quotes)
                            val type: Type = object : TypeToken<Map<String?, Any?>?>() {}.type
                            val map: Map<String, Any> = Gson().fromJson(currencies, type)
                            map.forEach { (k: String, v: Any) ->
                                if (v is Map<*, *>) {

                                } else {
                                    if (v.toString().toDouble() > 0) {
                                        if (k.equals("USD"+codeFrom)) {
                                            valueFromConverted = v.toString().toDouble()
                                            valueFrom = value / valueFromConverted
                                        } else if(k.equals("USD"+codeTo)){
                                            valueTo = v.toString().toDouble()
                                        }
                                    }
                                }
                            }
                            val result = valueFrom * valueTo
                            val result2Decimals = Math.round(result * 100) / 100.0
                            view?.hideProgress()
                            view?.setResult("Resultado: " + result2Decimals + " " + codeTo + " - " + descriptionTo)
                        }
                    },
                    { error ->
                        view?.hideProgress()
                        view?.showMsgError("Falha na requisição, tente novamente mais tarde.")
                    }
            )
            queue.add(jsonObjectRequest)
        }
    }

    fun valueIsConvert(): Float {
        try {
            var value = view?.getValueString()
            return value!!.replace(",", ".").toFloat()
        } catch (e: Exception){
            view?.showMsgError("Valor inválido!")
            return 0.0.toFloat();
        }
    }

    override fun onDestroy() {
        this.view = null
    }

    override fun validConvert(from: String, to: String): Boolean {
        if (from.isNullOrBlank() && to.isNullOrBlank()){
            view?.showMsgError("Selecione as moedas antes de efetuar a conversão.")
            return false
        } else if (from.isNullOrBlank()){
            view?.showMsgError("Selecione uma moeda de origem antes de efetuar a conversão.")
            return false
        } else if(to.isNullOrBlank()){
            view?.showMsgError("Selecione uma moeda de destino antes de efetuar a conversão.")
            return false
        } else {
            if (view?.getValueString().equals("")) {
                view?.showMsgError("Informe um valor para converter!")
                return false
            }
            return true
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (resultCode === AppCompatActivity.RESULT_OK) {
            var currencyCode: String? = data!!.getSerializableExtra("CURRENCYCODE") as String?
            var currencyDescription: String? = data!!.getSerializableExtra("CURRENCYDESCRIPTION") as String?
            if (requestCode === MainActivity.ACTIONFROM) {
                view?.confirmCurrencyFrom(currencyCode!!, currencyDescription!!)
            } else if(requestCode === MainActivity.ACTIONTO){
                view?.confirmCurrencyTo(currencyCode!!, currencyDescription!!)
            }
        }
    }

}