package academy.mukandrew.currencyconverter.data.remote.retrofit

import academy.mukandrew.currencyconverter.BuildConfig
import android.content.Context
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

class RetrofitConfig {
    private val accessKey: String = BuildConfig.ACCESS_KEY
    private val baseAPI: String = "http://api.currencylayer.com/"
    private val connectionTimeout: Long = 30000L
    private val ioTimeout: Long = 30000L

    fun getRetrofitConfig(context: Context): Retrofit {
        return Retrofit.Builder()
            .baseUrl(baseAPI)
            .addConverterFactory(GsonConverterFactory.create())
            .client(getOkHttpClient())
            .build()
    }

    private fun getOkHttpClient(): OkHttpClient {
        return OkHttpClient.Builder()
            .connectTimeout(connectionTimeout, TimeUnit.SECONDS)
            .writeTimeout(ioTimeout, TimeUnit.SECONDS)
            .readTimeout(ioTimeout, TimeUnit.SECONDS)
            .addInterceptor(AccessKeyInterceptor(accessKey))
            .build()
    }
}