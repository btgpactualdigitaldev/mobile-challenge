package com.example.cassiomobilechallenge.repositories

import androidx.lifecycle.MutableLiveData
import com.example.cassiomobilechallenge.Constants
import com.example.cassiomobilechallenge.interfaces.EndpointInterface
import com.example.cassiomobilechallenge.models.CurrencyResponse
import com.example.cassiomobilechallenge.models.QuotesResponse
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CurrencyRepository {

    fun getConnection(): EndpointInterface {
        return Connection.getRetrofitInstance(Constants.endpointPath).create(EndpointInterface::class.java)
    }

    fun getCurrencies(currencies: MutableLiveData<CurrencyResponse>, errorMessage: MutableLiveData<String>) {
        val callback = getConnection().getCurrencies(Constants.access_key, Constants.format)
        callback.enqueue(object : Callback<CurrencyResponse> {
            override fun onFailure(call: Call<CurrencyResponse>, t: Throwable) {
                errorMessage.postValue(t.message)
            }

            override fun onResponse(
                call: Call<CurrencyResponse>,
                response: Response<CurrencyResponse>
            ) {
                if (response.isSuccessful && response.body() != null) {
                    currencies.postValue(response.body())
                } else if (!response.isSuccessful) {
                    errorMessage.postValue(Constants.genericError)
                }
            }

        })
    }

    fun getAllConversions(currencies: MutableLiveData<QuotesResponse>, errorMessage: MutableLiveData<String>) {
        val callback = getConnection().getAllConversions(Constants.access_key, Constants.format)
        callback.enqueue(object : Callback<QuotesResponse> {
            override fun onFailure(call: Call<QuotesResponse>, t: Throwable) {
                errorMessage.postValue(t.message)
            }

            override fun onResponse(
                call: Call<QuotesResponse>,
                response: Response<QuotesResponse>
            ) {
                if (response.isSuccessful && response.body() != null) {
                    currencies.postValue(response.body())
                } else if (!response.isSuccessful) {
                    errorMessage.postValue(Constants.genericError)
                }
            }

        })
    }

    fun getConversion(currencies: MutableLiveData<QuotesResponse>, errorMessage: MutableLiveData<String>, toCurrency: String) {
        val callback = getConnection().getConversion(Constants.access_key, Constants.format, toCurrency)
        callback.enqueue(object : Callback<QuotesResponse> {
            override fun onFailure(call: Call<QuotesResponse>, t: Throwable) {
                errorMessage.postValue(t.message)
            }

            override fun onResponse(
                call: Call<QuotesResponse>,
                response: Response<QuotesResponse>
            ) {
                if (response.isSuccessful && response.body() != null) {
                    currencies.postValue(response.body())
                } else if (!response.isSuccessful) {
                    errorMessage.postValue(Constants.genericError)
                }
            }

        })
    }
}