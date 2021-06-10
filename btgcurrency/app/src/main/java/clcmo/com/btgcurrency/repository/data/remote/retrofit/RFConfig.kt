package clcmo.com.btgcurrency.repository.data.remote.retrofit

import android.content.Context
import clcmo.com.btgcurrency.util.constants.Constants.ACCESS_KEY
import clcmo.com.btgcurrency.util.constants.Constants.API_URL
import clcmo.com.btgcurrency.util.constants.Constants.CONN_LIMIT
import clcmo.com.btgcurrency.util.constants.Constants.IO_LIMIT
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class RFConfig {
    private val access: String = ACCESS_KEY

    fun getRFConfig(context: Context): Retrofit = Retrofit.Builder()
        .baseUrl(API_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .client(getOkHttpClient())
        .build()

    private fun getOkHttpClient() = OkHttpClient.Builder()
        .connectTimeout(CONN_LIMIT, TimeUnit.SECONDS)
        .writeTimeout(IO_LIMIT, TimeUnit.SECONDS)
        .readTimeout(IO_LIMIT, TimeUnit.SECONDS)
        .addInterceptor(KeyInterceptor(access))
        .build()
}