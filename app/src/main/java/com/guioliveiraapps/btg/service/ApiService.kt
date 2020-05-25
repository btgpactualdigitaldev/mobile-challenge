package com.guioliveiraapps.btg.service

import android.content.Context
import android.view.View
import androidx.lifecycle.MutableLiveData
import com.guioliveiraapps.btg.room.Currency
import com.guioliveiraapps.btg.response.CurrencyListResponse
import com.guioliveiraapps.btg.room.Quote
import com.guioliveiraapps.btg.response.QuoteListResponse
import com.guioliveiraapps.btg.room.CurrencyService
import com.guioliveiraapps.btg.room.QuoteService
import com.guioliveiraapps.btg.util.Constants
import com.guioliveiraapps.btg.util.Util
import okhttp3.HttpUrl
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Request
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


object ApiService {

    var httpClient: OkHttpClient.Builder
    var retrofit: Retrofit
    var repository: Api

    init {
        httpClient = OkHttpClient.Builder()
            .addInterceptor { chain: Interceptor.Chain ->
                var request: Request = chain.request()
                val url: HttpUrl = request.url().newBuilder()
                    .addQueryParameter(Constants.ACCESS_KEY, Constants.ACCESS_KEY_VALUE).build()
                request = request.newBuilder().url(url).build()
                chain.proceed(request)
            }

        retrofit = Retrofit.Builder()
            .baseUrl(Constants.BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .client(httpClient.build())
            .build()

        repository = retrofit.create(Api::class.java)
    }

    fun getCurrencies(
        context: Context,
        currencies: MutableLiveData<List<Currency>>,
        internetError: MutableLiveData<Boolean>,
        serverError: MutableLiveData<Boolean>,
        updateError: MutableLiveData<Int>
    ) {
        repository.getCurrencies().enqueue(object : Callback<CurrencyListResponse> {
            override fun onFailure(call: Call<CurrencyListResponse>, t: Throwable) {
                val roomCurrencies: List<Currency> = CurrencyService.getCurrencies(context)

                if (!roomCurrencies.isNullOrEmpty()) {
                    updateError.postValue(View.VISIBLE)
                    currencies.postValue(roomCurrencies)
                    return
                }

                if (!Util.hasConnectionToInternet(context)) {
                    internetError.postValue(true)
                } else {
                    serverError.postValue(true)
                }
            }

            override fun onResponse(
                call: Call<CurrencyListResponse>,
                response: Response<CurrencyListResponse>
            ) {
                if (response.body() == null ||
                    !response.body()!!.success ||
                    response.body()!!.currencies.isNullOrEmpty()
                ) {
                    if (!Util.hasConnectionToInternet(context)) {
                        internetError.postValue(true)
                    } else {
                        serverError.postValue(true)
                    }
                    return
                }

                val cur: List<Currency> =
                    Util.getCurrenciesFromResponse(response.body()!!.currencies)

                currencies.postValue(CurrencyService.resetCurrencies(context, cur))
            }

        })
    }

    fun getQuotes(
        context: Context,
        quotes: MutableLiveData<List<Quote>>,
        internetError: MutableLiveData<Boolean>,
        serverError: MutableLiveData<Boolean>,
        updateError: MutableLiveData<Int>
    ) {
        repository.getQuotes().enqueue(object : Callback<QuoteListResponse> {
            override fun onFailure(call: Call<QuoteListResponse>, t: Throwable) {
                val roomQuotes: List<Quote> = QuoteService.getQuotes(context)

                if (!roomQuotes.isNullOrEmpty()) {
                    updateError.postValue(View.VISIBLE)
                    quotes.postValue(roomQuotes)
                    return
                }

                if (!Util.hasConnectionToInternet(context)) {
                    internetError.postValue(true)
                } else {
                    serverError.postValue(true)
                }
            }

            override fun onResponse(
                call: Call<QuoteListResponse>,
                response: Response<QuoteListResponse>
            ) {
                if (response.body() == null ||
                    !response.body()!!.success ||
                    response.body()!!.quotes.isNullOrEmpty()
                ) {
                    if (!Util.hasConnectionToInternet(context)) {
                        internetError.postValue(true)
                    } else {
                        serverError.postValue(true)
                    }
                    return
                }

                val cur: List<Quote> =
                    Util.getQuotesFromResponse(response.body()?.quotes!!)

                quotes.postValue(QuoteService.resetQuotes(context, cur))
            }

        })
    }

}