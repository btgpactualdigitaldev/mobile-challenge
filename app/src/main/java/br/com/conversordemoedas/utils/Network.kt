package br.com.conversordemoedas.utils

import br.com.conversordemoedas.api.CurrencyLayerService
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class Network {

    companion object {
        const val CURRENCY_LAYER_BASE_URL = "http://api.currencylayer.com/"
    }

    private val currencyRetrofit = Retrofit.Builder().baseUrl(CURRENCY_LAYER_BASE_URL).addConverterFactory(GsonConverterFactory.create()).build()

    fun currencyLayerService(): CurrencyLayerService = currencyRetrofit.create(CurrencyLayerService::class.java)

}