package com.example.exchange.utils

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class Network {

    companion object {

        private const val URL_DOMAIN = "https://btg-mobile-challenge.herokuapp.com"

        fun getEndpoint() : Endpoint? {
            return Retrofit.Builder()
                .baseUrl(URL_DOMAIN)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
                .create(Endpoint::class.java)
        }
    }
}