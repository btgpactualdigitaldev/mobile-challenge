package com.br.btgteste.data.remote

import com.br.btgteste.BuildConfig
import okhttp3.Interceptor
import okhttp3.Response

class  HttpInterceptor : Interceptor {

    override fun intercept(chain: Interceptor.Chain): Response {
        val baseUrl = chain.request().url
        val urlWithQuery = baseUrl.newBuilder()
            .addEncodedQueryParameter("access_key", BuildConfig.ACCESS_TOKEN)
            .build()
        val concatenatedUrl = chain.request().newBuilder().url(urlWithQuery).build()
        return chain.proceed(concatenatedUrl)
    }
}