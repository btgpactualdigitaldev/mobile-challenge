package br.com.convertify.api

import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.converter.scalars.ScalarsConverterFactory


object ApiClient {
    private var retrofit: Retrofit? = null

    fun getRetrofitClient(): Retrofit {
        if (retrofit == null) {
            val client = OkHttpClient.Builder().build()
            retrofit = Retrofit.Builder()
                .client(client)
                .addConverterFactory(ScalarsConverterFactory.create())
                .addConverterFactory(GsonConverterFactory.create())
                .baseUrl(Constants.API_BASE_URL)
                .build()
        }
        return retrofit!!
    }

}