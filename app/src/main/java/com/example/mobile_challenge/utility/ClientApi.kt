package com.example.mobile_challenge.utility

import io.ktor.client.HttpClient
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.http.takeFrom

class ClientApi {

    private val url = "http://api.currencylayer.com"
    private val key = "e8af0ceaeac239335961d0151a4507b7"

    private val client = HttpClient(OkHttp)

    suspend fun httpRequestGetList(): String {
        return client.get {
            parameter("access_key", key )
            url {
                takeFrom(this@ClientApi.url)
                encodedPath = "/list"
            }
        }
    }

    suspend fun httpRequestGetLive(): String {
        return client.get {
            parameter("access_key", key )
            url {
                takeFrom(this@ClientApi.url)
                encodedPath = "/live"
            }
        }
    }
}