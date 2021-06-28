package br.com.gft.infrastructure.interceptor

import android.content.Context
import br.com.gft.R
import br.com.gft.infrastructure.util.ConnectionUtil
import okhttp3.Interceptor
import okhttp3.Response
import java.io.IOException
import java.net.InetSocketAddress
import java.net.Socket

class NoConnectionInterceptor(
    private val context: Context
) : Interceptor {

    override fun intercept(chain: Interceptor.Chain): Response {
        return if (!isConnectionOn()) {
            throw NoConnectivityException(context.getString(R.string.no_connectivity_exception))
        } else if(!isInternetAvailable()) {
            throw NoInternetException(context.getString(R.string.no_internet_exception))
        } else {
            chain.proceed(chain.request())
        }
    }

    private fun isConnectionOn(): Boolean {
        return ConnectionUtil(context).isConnectionOn()
    }

    private fun isInternetAvailable(): Boolean {
        return try {
            val timeoutMs = 1500
            val sock = Socket()
            val sockaddr = InetSocketAddress("8.8.8.8", 53)

            sock.connect(sockaddr, timeoutMs)
            sock.close()

            true
        } catch (e: IOException) {
            false
        }
    }
}

class NoConnectivityException(private val textMsg: String) : IOException() {
    override val message: String
        get() = textMsg
}

class NoInternetException(private val textMsg: String) : IOException() {
    override val message: String
        get() = textMsg
}