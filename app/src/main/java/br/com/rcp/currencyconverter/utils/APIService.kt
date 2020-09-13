package br.com.rcp.currencyconverter.utils

import br.com.rcp.currencyconverter.dto.CurrencyLayerDTO
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface APIService {
    @GET("/list")
    suspend fun getCurrencies(): Response<CurrencyLayerDTO>

    @GET("/live")
    suspend fun getValues(): Response<CurrencyLayerDTO>
}