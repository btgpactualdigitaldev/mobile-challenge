package com.example.desafiobtg.rest

import com.example.desafiobtg.constants.Constants
import com.example.desafiobtg.models.CoinsDTO
import com.example.desafiobtg.models.QuotationDTO
import retrofit2.Call
import retrofit2.http.GET

interface ApiInterface {

    @GET(Constants.COIN_LIST)
    fun getCoinList(): Call<CoinsDTO>

    @GET(Constants.CURRENCY_QUOTE)
    fun getQuotation(): Call<QuotationDTO>
}
