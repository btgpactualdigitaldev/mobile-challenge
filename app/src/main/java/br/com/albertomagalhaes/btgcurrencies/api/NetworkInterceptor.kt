package br.com.albertomagalhaes.btgcurrencies.api

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import br.com.albertomagalhaes.btgcurrencies.R
import okhttp3.Interceptor
import okhttp3.Response
import java.io.IOException

class NetworkInterceptor(
    context: Context
) : Interceptor {

    private val applicationContext = context.applicationContext

    override fun intercept(chain: Interceptor.Chain): Response {
        if (!isInternetAvailable())
            throw NoInternetConnectionException(
                applicationContext.getString(R.string.network_interceptor_error)
            )
        return chain.proceed(chain.request())
    }

    private fun isInternetAvailable(): Boolean {
        var result = false
        val connectivityManager =
            applicationContext.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager?
        connectivityManager?.let {
            it.getNetworkCapabilities(connectivityManager.activeNetwork)?.apply {
                result = when {
                    hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
                    hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true
                    else -> false
                }
            }
        }
        return result
    }

    class NoInternetConnectionException(message: String) : IOException(message)

}