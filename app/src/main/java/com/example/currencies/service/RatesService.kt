package com.example.currencies.service

import com.example.currencies.model.remote.RatesModelRemote
import retrofit2.Call
import retrofit2.http.GET

interface RatesService {

     @GET("live")
     fun getAllRates(): Call<RatesModelRemote>

}