package clcmo.com.btgcurrency.repository.data.remote.retrofit

import okhttp3.Interceptor
import okhttp3.Response

class KeyInterceptor(private val tokenAccess: String) : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        var req = chain.request()
        val url = req.url().newBuilder().addQueryParameter("access_key", tokenAccess).build()
        req = req.newBuilder().url(url).build()
        return chain.proceed(req)
    }
}