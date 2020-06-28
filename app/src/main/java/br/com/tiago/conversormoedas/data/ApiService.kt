package br.com.tiago.conversormoedas.data

import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

object ApiService {

    private fun initRetrofit() : Retrofit {
        return Retrofit.Builder()
            .baseUrl("http://api.currencylayer.com/")
            .addConverterFactory(MoshiConverterFactory.create())
            .build()
    }

    val service: CurrencyServices = initRetrofit().create(
        CurrencyServices::class.java)

}