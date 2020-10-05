package academy.mukandrew.currencyconverter.data.remote.retrofit

import okhttp3.Interceptor
import okhttp3.Response

class AccessKeyInterceptor(
    private val token: String
) : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        var request = chain.request()
        val httpUrl = request.url().newBuilder().addQueryParameter("access_key", token).build()
        request = request.newBuilder().url(httpUrl).build()
        return chain.proceed(request)
    }
}