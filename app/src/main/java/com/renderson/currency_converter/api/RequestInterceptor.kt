package com.renderson.currency_converter.api

import com.renderson.currency_converter.other.Constants
import okhttp3.Interceptor
import okhttp3.Request
import okhttp3.Response
import javax.inject.Singleton

@Singleton
class RequestInterceptor: Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request()
        val originalUrl = request.url

        val newUrl = originalUrl.newBuilder()
            .addQueryParameter("access_key", Constants.MY_KEY_API)
            .build()

        val requestBuilder: Request.Builder = request.newBuilder().url(newUrl)
        return chain.proceed(requestBuilder.build())
    }
}