package com.vald3nir.data.rest

import com.vald3nir.data.BuildConfig
import com.vald3nir.data.database.model.Currency
import com.vald3nir.data.database.model.Exchange
import com.vald3nir.data.exceptions.RequestHttpException
import com.vald3nir.data.rest.mapper.toCurrencyList
import com.vald3nir.data.rest.mapper.toExchangeList
import com.vald3nir.data.rest.services.CurrencyLayerService
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class RestClient {

    private val retrofit: Retrofit = Retrofit.Builder()
        .addConverterFactory(GsonConverterFactory.create())
        .baseUrl("http://api.currencylayer.com/")
        .client(getClient())
        .build()

    private fun getClient(): OkHttpClient {
        return OkHttpClient.Builder()
            .addNetworkInterceptor { chain ->
                val originalRequest = chain.request()
                val newUrlBuilder = originalRequest.url.newBuilder()
                val newUrl = newUrlBuilder.addQueryParameter(
                    "access_key", BuildConfig.CURRENCY_LAYER_API_KEY
                ).build()
                val newRequest = originalRequest.newBuilder().url(newUrl).build()
                chain.proceed(newRequest)
            }
            .addInterceptor(getLoggingInterceptor())
            .callTimeout(60, TimeUnit.SECONDS)
            .connectTimeout(60, TimeUnit.SECONDS)
            .readTimeout(60, TimeUnit.SECONDS)
            .writeTimeout(60, TimeUnit.SECONDS)
            .build()
    }

    private fun getLoggingInterceptor() =
        HttpLoggingInterceptor().apply {
            this.setLevel(HttpLoggingInterceptor.Level.BODY)
        }


    @Throws(Exception::class)
    suspend fun listCurrencies(): List<Currency> {
        val service: CurrencyLayerService = retrofit.create(CurrencyLayerService::class.java)
        val response = service.listCurrencies()
        val body = response.body()
        if (response.code() == 200) {
            return body?.currencies.toCurrencyList()
        } else {
            throw RequestHttpException(response.code())
        }
    }

    @Throws(Exception::class)
    suspend fun listExchanges(): List<Exchange> {
        val service: CurrencyLayerService = retrofit.create(CurrencyLayerService::class.java)
        val response = service.listExchanges()
        val body = response.body()
        if (response.code() == 200) {
            return body?.quotes.toExchangeList()
        } else {
            throw RequestHttpException(response.code())
        }
    }
}