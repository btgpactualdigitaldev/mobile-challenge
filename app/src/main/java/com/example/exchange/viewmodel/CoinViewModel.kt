package com.example.exchange.viewmodel

import android.util.Log
import android.view.View
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.exchange.model.CoinDetails
import com.example.exchange.model.ListCoin
import com.example.exchange.utils.Network
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CoinViewModel : ViewModel() {

    private val loading: MutableLiveData<Int> = MutableLiveData()
    private val data: MutableLiveData<List<CoinDetails>> = MutableLiveData()
    private val error: MutableLiveData<Throwable> = MutableLiveData()

    private lateinit var items: Map<String, String>

    fun getLoading(): LiveData<Int> {
        return loading
    }

    fun getData(): LiveData<List<CoinDetails>> {
        return data
    }

    fun getError(): LiveData<Throwable> {
        return error
    }

    fun requestData() {
        View.VISIBLE.also { loading.value = it }

        Network.getEndpoint()?.getListCoins()?.enqueue(object : Callback<ListCoin> {
            override fun onResponse(call: Call<ListCoin>, response: Response<ListCoin>) {
                View.GONE.also { loading.value = it }

                response.body()?.currencies.also { it ->
                    if (it != null) {
                        items = it
                        createDataList(filter = "", orderByAbbreviation = false, orderByDescription = false)
                    }
                }

                Log.i(this.javaClass.name, "status code: ${response.code()}, data: ${response.body()}")
            }

            override fun onFailure(call: Call<ListCoin>, exception: Throwable) {
                View.GONE.also { loading.value = it }
                exception.also { error.value = it }
                Log.i(this.javaClass.name, "failure: error request data", exception)
            }
        })
    }

    fun createDataList(filter: String, orderByAbbreviation: Boolean, orderByDescription: Boolean) {
        val listCoinDetails: MutableList<CoinDetails> = mutableListOf()

        items.forEach { (k, v) ->
            when {
                filter.isNotEmpty() -> {
                    when {
                        filter.toLowerCase().toRegex().containsMatchIn(k.toLowerCase()) || filter.toLowerCase().toRegex().containsMatchIn(v.toLowerCase()) -> {
                            listCoinDetails.add(CoinDetails(k, v))
                        }
                    }
                }
                else -> {
                    listCoinDetails.add(CoinDetails(k, v))
                }
            }
        }

        when {
            orderByAbbreviation -> {
                listCoinDetails.also { data.value = it.sortedBy { it.abbreviation } }
            }
            orderByDescription -> {
                listCoinDetails.also { data.value = it.sortedBy { it.description } }
            }
            else -> {
                listCoinDetails.also { data.value = it }
            }
        }
    }
}