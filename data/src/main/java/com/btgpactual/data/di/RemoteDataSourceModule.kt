package com.btgpactual.data.di

import com.btgpactual.data.remote.api.CurrencyLayerApi
import com.btgpactual.data.remote.model.CurrencyPayload
import com.btgpactual.data.remote.source.ListRemoteDataSource
import com.btgpactual.data.remote.source.ListRemoteDataSourceImpl
import com.btgpactual.data.remote.source.LiveRemoteDataSource
import com.btgpactual.data.remote.source.LiveRemoteDataSourceImpl
import com.btgpactual.data.remote.typeadapter.CurrencyPayloadTypeAdapter
import com.btgpactual.data.remote.typeadapter.QuotePayloadTypeAdapter
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import okhttp3.OkHttpClient
import org.koin.dsl.module
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit
import com.btgpactual.data.remote.model.QuotePayload


val remoteDataSourceModule = module {
    factory { providesOkHttpClient() }
    factory { providesGsonCoverterFactory()}
    single {
        createWebService<CurrencyLayerApi>(
            okHttpClient = get(),
            gsonConverterFactory = get(),
            url = "http://api.currencylayer.com"
        )
    }

    factory<ListRemoteDataSource> {
        ListRemoteDataSourceImpl(api = get())
    }

    factory<LiveRemoteDataSource> {
        LiveRemoteDataSourceImpl(api = get())
    }
}


fun providesGsonCoverterFactory() : GsonConverterFactory{
    val gson =
        GsonBuilder()
            .registerTypeAdapter(CurrencyPayload::class.java, CurrencyPayloadTypeAdapter())
            .registerTypeAdapter(QuotePayload::class.java,QuotePayloadTypeAdapter())
            .create()

    return GsonConverterFactory.create(gson)
}

fun providesOkHttpClient(): OkHttpClient {
    return OkHttpClient.Builder()
        .connectTimeout(30, TimeUnit.SECONDS)
        .readTimeout(30, TimeUnit.SECONDS)
        .writeTimeout(30, TimeUnit.SECONDS)
        .build()
}

inline fun <reified T> createWebService(
    okHttpClient: OkHttpClient,
    gsonConverterFactory: GsonConverterFactory,
    url: String
): T {
    return Retrofit.Builder()
        .addConverterFactory(gsonConverterFactory)
        .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
        .baseUrl(url)
        .client(okHttpClient)
        .build()
        .create(T::class.java)
}