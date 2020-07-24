package com.desafio.btgpactual.http

import android.util.Log
import com.desafio.btgpactual.http.service.ApiService
import com.desafio.btgpactual.shared.constants.API_KEY
import com.desafio.btgpactual.shared.constants.BASE_URL
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitConfig {

    private val retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .client(httpClient())
        .build()

    fun apiService() = retrofit.create(ApiService::class.java)

    fun httpClient(): OkHttpClient {
        val httpClient = OkHttpClient
            .Builder()
            .addInterceptor { chain: Interceptor.Chain ->
                val request = chain
                    .request()
                    .url()
                    .newBuilder()
                    .addQueryParameter("access_key", API_KEY)
                    .build()
                val changedUrl = chain.request().newBuilder().url(request).build()

                chain.proceed(changedUrl)
            }
            .build()
        return httpClient
    }
}
