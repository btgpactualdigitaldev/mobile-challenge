package br.com.gft.infrastructure.injection

import android.content.Context
import br.com.gft.CurrencyConverter
import br.com.gft.infrastructure.interceptor.ApiKeyInterceptor
import br.com.gft.infrastructure.interceptor.NoConnectionInterceptor
import okhttp3.OkHttpClient
import org.koin.dsl.module
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit


object NetworkModule {

    val dependencyModule = module{
        single { provideRetrofit(get()) }
        single { provideOkHttpClient(CurrencyConverter.appContext) }
    }

    fun provideOkHttpClient(
        context: Context
    ): OkHttpClient {
        val builder = OkHttpClient.Builder()
            .readTimeout(1, TimeUnit.MINUTES)
            .connectTimeout(1, TimeUnit.MINUTES)
            .followRedirects(true)
            .addInterceptor(NoConnectionInterceptor(context))
            .addInterceptor(ApiKeyInterceptor())

        return builder.build()
    }

    private fun provideRetrofit(
        client: OkHttpClient
    ): Retrofit = Retrofit.Builder()
        .baseUrl("http://api.currencylayer.com/")
        .client(client)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
}