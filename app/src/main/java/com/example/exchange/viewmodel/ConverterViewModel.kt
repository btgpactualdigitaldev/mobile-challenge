package com.example.exchange.viewmodel

import android.util.Log
import android.view.View
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.exchange.model.LiveCoin
import com.example.exchange.utils.Network
import com.example.exchange.utils.coinFormatted
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ConverterViewModel : ViewModel() {

    private val loading: MutableLiveData<Int> = MutableLiveData()
    private val data: MutableLiveData<List<String>> = MutableLiveData()
    private val error: MutableLiveData<Throwable> = MutableLiveData()
    private val result: MutableLiveData<String> = MutableLiveData()

    private lateinit var items: Map<String, Double>

    fun getLoading(): LiveData<Int> {
        return loading
    }

    fun getData(): LiveData<List<String>> {
        return data
    }

    fun getError(): LiveData<Throwable> {
        return error
    }

    fun getResult(): LiveData<String> {
        return result
    }

    fun requestData() {
        View.VISIBLE.also { loading.value = it }

        Network.getEndpoint()?.getLiveCoins()?.enqueue(object : Callback<LiveCoin> {
            override fun onResponse(call: Call<LiveCoin>, response: Response<LiveCoin>) {
                View.GONE.also { loading.value = it }

                response.body()?.quotes.also { it ->
                    if (it != null) {
                        items = it
                        createDataSpinner()
                    }
                }

                Log.i(this.javaClass.name, "status code: ${response.code()}, data: ${response.body()}")
            }

            override fun onFailure(call: Call<LiveCoin>, exception: Throwable) {
                View.GONE.also { loading.value = it }
                exception.also { error.value = it }
                Log.i(this.javaClass.name, "failure: error request data", exception)
            }
        })
    }

    fun createDataSpinner() {
        val listInitials: MutableList<String> = mutableListOf()

        items.forEach { (k, v) ->
            listInitials.add(k.substring(3, 6))
        }

        listInitials.also { data.value = it }
    }

    fun conversionBetweenValues(firstCoin: String, secondCoin: String, value: String) {
        val firstCoinQuote = items.getValue("USD$firstCoin")
        val secondCoinQuote = items.getValue("USD$secondCoin")
        var count: Double

        when {
            value.isNotEmpty() -> {
                 count = value.toDouble() / firstCoinQuote * secondCoinQuote
                "${value.coinFormatted()} ($firstCoin) = ${count.toString().coinFormatted()} ($secondCoin)".also { result.value = it }
            }
            else -> {
                "".also { result.value = it }
            }
        }
    }
}