package com.carlos.silva.desafiobtg.ui

import android.content.Context
import android.net.ConnectivityManager
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.carlos.silva.desafiobtg.data.networks.CurrencyLayerLoader
import com.carlos.silva.desafiobtg.toArrayPair
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import java.lang.Math.floor
import java.lang.Math.round

class MainViewModel : ViewModel() {

//    ViewModelPrincipal

    val selectdOriginLiveData: MutableLiveData<Pair<String, String>> = MutableLiveData()
    val selectedDestinyLiveData: MutableLiveData<Pair<String, String>> = MutableLiveData()
    val valueToFormat: MutableLiveData<Double> = MutableLiveData()
    val formatResultLiveData: MutableLiveData<String> = MutableLiveData()
    val formattedResultInfoLiveData: MutableLiveData<String> = MutableLiveData()
    val isConnectedLiveData: MutableLiveData<Boolean> = MutableLiveData()

    val currenciesLiveData: MutableLiveData<MutableList<Pair<String, String>>> = MutableLiveData()
    val quotesLiveData: MutableLiveData<MutableList<Pair<String, Double>>> = MutableLiveData()

    fun getCurrencies(context: Context) {

        if (isConnectedLiveData.value == false || isConnectedLiveData.value == null)
            return

        viewModelScope.launch {
            val responseCurrencies =
                async { CurrencyLayerLoader.loadCurrencies(context) }
                    .await()

            responseCurrencies?.let { c ->
                c.currencies?.let {
                    currenciesLiveData.value = it.toArrayPair()
                }
            }
        }
    }

    fun getQuotes(context: Context) {

        if (isConnectedLiveData.value == false || isConnectedLiveData.value == null)
            return

        viewModelScope.launch {
            val respondeQuotes =
                async { CurrencyLayerLoader.loadQuotes(context) }
                    .await()

            respondeQuotes?.let { c ->
                c.quotes?.let {
                    quotesLiveData.value = it.toArrayPair()
                }
            }
        }
    }

    fun isValidate(): Boolean {
        return !(selectdOriginLiveData.value == null || selectedDestinyLiveData.value == null)
    }

    fun getResult() {

        val origin = selectdOriginLiveData.value
        val destiny = selectedDestinyLiveData.value
        val valueFormat = valueToFormat.value
        val quotes = quotesLiveData.value

        if (origin?.first != "USD" && destiny?.first != "USD") {
            val rateOrigin = quotes?.find { it.first.contains(origin?.first.toString()) }
            val rateDestiny = quotes?.find { it.first.contains(destiny?.first.toString()) }
            rateOrigin?.let { ro ->
                rateDestiny?.let { rd ->
                    valueFormat?.let { v ->
                        val a = v / rateOrigin.second
                        val r = a * rd.second
                        formattedResultInfoLiveData.value =
                            "De ${origin?.first}\nPara ${destiny?.first}"
                        formatResultLiveData.value = String.format("%.2f", r)
                    }
                }
            }
        } else if (origin?.first == "USD" && destiny?.first != "USD") {
            val rateDestiny = quotes?.find { it.first.contains(destiny?.first.toString()) }
            rateDestiny?.let { rd ->
                valueFormat?.let { v ->
                    val r = v * rd.second
                    formattedResultInfoLiveData.value =
                        "De ${origin?.first}\nPara ${destiny?.first}"
                    formatResultLiveData.value = String.format("%.2f", r)
                }
            }
        } else {
            val rateOrigin = quotes?.find { it.first.contains(origin?.first.toString()) }
            rateOrigin?.let { ro ->
                valueFormat?.let { v ->
                    val r = v / rateOrigin.second
                    formattedResultInfoLiveData.value =
                        "De ${origin?.first}\nPara ${destiny?.first}"
                    formatResultLiveData.value = String.format("%.2f", r)
                }
            }
        }
    }
}