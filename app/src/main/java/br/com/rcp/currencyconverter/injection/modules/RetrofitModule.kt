package br.com.rcp.currencyconverter.injection.modules

import br.com.rcp.currencyconverter.Constants
import br.com.rcp.currencyconverter.utils.APIService
import com.jakewharton.retrofit2.adapter.kotlin.coroutines.CoroutineCallAdapterFactory
import dagger.Module
import dagger.Provides
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Response
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit
import javax.inject.Singleton

@Module
object RetrofitModule {
    @Provides
    @Singleton
    fun provideOKHTTPClient(interceptor: Interceptor): OkHttpClient {
        return OkHttpClient.Builder().apply {
            addInterceptor(HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.NONE))
            connectTimeout(30, TimeUnit.SECONDS)
            writeTimeout(120, TimeUnit.SECONDS)
            readTimeout(120, TimeUnit.SECONDS)
            addInterceptor(interceptor)
        }.build()
    }

    @Provides
    @Singleton
    fun provideAPI(retrofit: Retrofit): APIService {
        return retrofit.create(APIService::class.java)
    }

    @Provides
    @Singleton
    fun provideRetrofit(client: OkHttpClient): Retrofit {
        return Retrofit.Builder().apply {
            baseUrl(Constants.API_BASE)
            client(client)
            addConverterFactory(GsonConverterFactory.create())
            addCallAdapterFactory(CoroutineCallAdapterFactory())
        }.build()
    }

    @Provides
    @Singleton
    fun provideTokenInterceptor(): Interceptor {
        return object : Interceptor {
            override fun intercept(chain: Interceptor.Chain): Response {
                val original    = chain.request()
                val key         = Constants.API_KEY
                val url         = original.url.newBuilder().addQueryParameter("access_key", key).build()
                val request     = original.newBuilder().url(url).build()
                return chain.proceed(request)
            }
        }
    }
}