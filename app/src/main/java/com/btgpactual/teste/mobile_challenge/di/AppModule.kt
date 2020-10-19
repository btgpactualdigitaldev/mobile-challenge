package com.btgpactual.teste.mobile_challenge.di

import android.util.Log
import com.btgpactual.teste.mobile_challenge.MainApplication
import com.btgpactual.teste.mobile_challenge.R
import com.btgpactual.teste.mobile_challenge.data.local.MainDatabase
import com.btgpactual.teste.mobile_challenge.data.remote.SyncApi
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import dagger.Module
import dagger.Provides
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import javax.inject.Singleton

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Module
class AppModule {

    @Singleton
    @Provides
    fun providesOkHttpClient(): OkHttpClient {

        val clientBuilder = OkHttpClient().newBuilder()

        val interceptor =
            HttpLoggingInterceptor { message ->
                Log.d("Retrofit", message)
            }
        interceptor.level = HttpLoggingInterceptor.Level.BODY

        return clientBuilder.addInterceptor(interceptor).build()
    }

    @Singleton
    @Provides
    fun provideRetrofitInstance(mainApplication: MainApplication, client: OkHttpClient): Retrofit {
        return Retrofit.Builder()
            .baseUrl(mainApplication.getString(R.string.baseUrl))
            .client(client)
            .addConverterFactory(
                MoshiConverterFactory.create(
                    Moshi.Builder()
                    .add(KotlinJsonAdapterFactory())
                    .build())
            ).build()
    }

    @Singleton
    @Provides
    fun provideSyncApi(retrofit: Retrofit): SyncApi {
        return retrofit.create(SyncApi::class.java)
    }

    @Singleton
    @Provides
    fun providesMainDatabase(mainApplication: MainApplication): MainDatabase {
        return MainDatabase.getInstance(mainApplication)
    }
}