package br.com.btgpactual.currencyconverter.data.retrofit

import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

object ApiService {

    private fun initRetrofit() : Retrofit {
        return Retrofit.Builder()
            .baseUrl("http://api.currencylayer.com/")
            .addConverterFactory(
                MoshiConverterFactory.create(
                    Moshi.Builder()
                        .add(KotlinJsonAdapterFactory())
                        .build()
                )
            )
            .build()
    }

    val service : CurrencyLayerServices = initRetrofit().create(CurrencyLayerServices::class.java)
}