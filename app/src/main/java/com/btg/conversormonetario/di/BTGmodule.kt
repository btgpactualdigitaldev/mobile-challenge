package com.btg.conversormonetario.di

import android.app.Application
import android.content.SharedPreferences
import com.btg.conversormonetario.BuildConfig
import com.btg.conversormonetario.business.database.DataManager
import com.btg.conversormonetario.business.repository.BaseRepository
import com.btg.conversormonetario.business.repository.CurrencyRepository
import com.btg.conversormonetario.business.repository.WelcomeRepository
import com.btg.conversormonetario.view.viewmodel.BaseViewModel
import com.btg.conversormonetario.view.viewmodel.ChooseCurrencyViewModel
import com.google.gson.GsonBuilder
import com.btg.conversormonetario.data.service.Api
import com.btg.conversormonetario.view.adapter.ListCurrencyAdapter
import com.btg.conversormonetario.view.adapter.SpinnerAdapter
import com.btg.conversormonetario.view.fragment.BottomSheetOptionFragment
import com.btg.conversormonetario.view.viewmodel.ConverterCurrencyViewModel
import com.btg.conversormonetario.view.viewmodel.WelcomeViewModel
import com.btg.conversormonetario.data.service.CoroutineCallAdapterFactory
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import org.koin.android.ext.koin.androidApplication
import org.koin.dsl.module
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.security.SecureRandom
import java.security.cert.X509Certificate
import java.util.concurrent.TimeUnit
import javax.net.ssl.SSLContext
import javax.net.ssl.SSLSession
import javax.net.ssl.TrustManager
import javax.net.ssl.X509TrustManager

const val TIMEOUT_30_SECONDS = 30L
const val BASE_URL = "https://api.currencylayer.com/api/"
const val BTG_PREFERENCES = "btg_preferences"
const val SSL = "SSL"

val viewModelModules = module {
    factory { BaseViewModel(get(), get()) }
    factory { WelcomeViewModel(get(), get(), get()) }
    factory { ConverterCurrencyViewModel(get(), get(), get()) }
    factory { ChooseCurrencyViewModel(get(), get()) }
}

val adapterModules = module {
    factory { ListCurrencyAdapter(get(), get(), get()) }
    factory { SpinnerAdapter(get(), get()) }
}

val fragmentModules = module {
    factory { BottomSheetOptionFragment(get(), get()) }
}

val repositoryModules = module {
    single { BaseRepository(get()) }
    single { WelcomeRepository(get()) }
    single { CurrencyRepository(get()) }
}

val dataManagerModules = module {
    factory { DataManager(get()) }
    factory { getSharedPrefs(androidApplication()) }
    factory<SharedPreferences.Editor> { getSharedPrefs(androidApplication()).edit() }
}

val serviceModules = module {
    single {
        createWebService<Api>(
            okHttpClient = createHttpClient(),
            baseUrl = BASE_URL
        )
    }
}

fun getSharedPrefs(androidApplication: Application): SharedPreferences =
    androidApplication.getSharedPreferences(BTG_PREFERENCES, android.content.Context.MODE_PRIVATE)

fun createHttpClient(): OkHttpClient = getUnsafeOkHttpClient()
    .newBuilder()
    .connectTimeout(TIMEOUT_30_SECONDS, TimeUnit.SECONDS)
    .writeTimeout(TIMEOUT_30_SECONDS, TimeUnit.SECONDS)
    .readTimeout(TIMEOUT_30_SECONDS, TimeUnit.SECONDS)
    .addInterceptor(configDebugLog())
    .build()

fun getUnsafeOkHttpClient(): OkHttpClient {
    return try {
        val trustAllCerts =
            arrayOf<TrustManager>(
                object : X509TrustManager {
                    override fun checkClientTrusted(
                        chain: Array<X509Certificate>,
                        authType: String
                    ) {
                    }

                    override fun checkServerTrusted(
                        chain: Array<X509Certificate>,
                        authType: String
                    ) {
                    }

                    override fun getAcceptedIssuers(): Array<X509Certificate> {
                        return arrayOf()
                    }
                }
            )
        val sslContext = SSLContext.getInstance(SSL)
        sslContext.init(null, trustAllCerts, SecureRandom())
        val sslSocketFactory = sslContext.socketFactory
        val builder = OkHttpClient.Builder()
        builder.sslSocketFactory(
            sslSocketFactory,
            trustAllCerts[0] as X509TrustManager
        )
        builder.hostnameVerifier { hostname: String?, session: SSLSession? -> true }
        builder.build()
    } catch (e: Exception) {
        throw RuntimeException(e)
    }
}

inline fun <reified T> createWebService(
    okHttpClient: OkHttpClient, baseUrl: String
): T {
    val retrofit = Retrofit.Builder()
        .baseUrl(baseUrl)
        .addConverterFactory(GsonConverterFactory.create(GsonBuilder().setLenient().create()))
        .addCallAdapterFactory(CoroutineCallAdapterFactory())
        .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
        .client(okHttpClient)
        .build()
    return retrofit.create(T::class.java)
}

private fun configDebugLog(): HttpLoggingInterceptor {
    val log = HttpLoggingInterceptor()
    if (BuildConfig.DEBUG)
        log.level = HttpLoggingInterceptor.Level.BODY
    return log
}