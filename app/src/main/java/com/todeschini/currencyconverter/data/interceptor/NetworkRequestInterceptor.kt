package com.todeschini.currencyconverter.data.interceptor

import okhttp3.Interceptor
import okhttp3.Request
import okhttp3.Response

class NetworkRequestInterceptor: Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        var request = chain.request()
        val originalUrl = request.url()

        val newUrl = originalUrl.newBuilder()
            .addQueryParameter("access_key", "94c12caf9e215a10fee981f66ac5638f")
            .build()

        val requestBuilder: Request.Builder = request.newBuilder().url(newUrl)

        return chain.proceed(requestBuilder.build())
    }
}