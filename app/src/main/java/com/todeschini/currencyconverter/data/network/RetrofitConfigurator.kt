package com.todeschini.currencyconverter.data.network

import com.todeschini.currencyconverter.data.interceptor.NetworkRequestInterceptor
import com.todeschini.currencyconverter.utils.Constants
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitConfigurator {

    companion object {

        private fun getOkHTTPClient(): OkHttpClient {
            return OkHttpClient.Builder()
                .addNetworkInterceptor(NetworkRequestInterceptor())
                .build()
        }

        private fun getRetrofitInstance(): Retrofit {
            return Retrofit.Builder()
                .baseUrl(Constants.BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .client(getOkHTTPClient())
                .build()
        }

        val endpointService: IEndpoint = getRetrofitInstance().create(IEndpoint::class.java)
    }
}