package br.com.daccandido.currencyconverterapp.data

import br.com.daccandido.currencyconverterapp.data.model.URL_BASE
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object ApiService {

    private fun initRetrofit(): Retrofit {
        return Retrofit.Builder()
            .addConverterFactory(GsonConverterFactory.create())
            .baseUrl(URL_BASE)
            .build()
    }

    val service: RequestAPI = initRetrofit().create(RequestAPI::class.java)
}