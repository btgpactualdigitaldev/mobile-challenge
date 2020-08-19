package com.kaleniuk2.conversordemoedas.data.remote

import android.os.AsyncTask
import com.kaleniuk2.conversordemoedas.common.network.NetworkRequestManager
import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.parser.CurrencyParser

class CurrencyRemoteDataSource<T>(val callback: (T) -> Unit) :
    AsyncTask<CurrencyRemoteDataSource.ENDPOINT, Unit, T>() {
    enum class ENDPOINT(var additionalParams: String = "") {
        LIST, LIVE
    }

    companion object {
        private var API_URL = "http://api.currencylayer.com/"
        private const val API_KEY = "?access_key=1d08dfaeaf855d465642aa490f115c8f"
        private const val LIST_ENDPOINT = "list"
        private const val LIVE_ENDPOINT = "live"

        fun changeUrlForTesting() {
            API_URL = "http://localhost:8080/"
        }
    }

    override fun doInBackground(vararg params: ENDPOINT): T {
        when (val endPoint = params[0]) {
            ENDPOINT.LIST -> {
                return when (val resultJson =
                    NetworkRequestManager.makeRequest("$API_URL$LIST_ENDPOINT$API_KEY")) {
                    is DataWrapper.Success -> {
                        CurrencyParser.toListCurrencies(resultJson.value) as T
                    }
                    is DataWrapper.Error ->
                        DataWrapper.Error(resultJson.error) as T
                }
            }
            ENDPOINT.LIVE -> {
                return when (val resultJson =
                    NetworkRequestManager.makeRequest("$API_URL$LIVE_ENDPOINT$API_KEY&currencies=${endPoint.additionalParams}")) {
                    is DataWrapper.Success -> {
                        CurrencyParser.toQuotes(resultJson.value) as T
                    }
                    is DataWrapper.Error ->
                        DataWrapper.Error(resultJson.error) as T
                }
            }
        }
    }

    override fun onPostExecute(result: T) {
        super.onPostExecute(result)
        callback(result)
    }
}