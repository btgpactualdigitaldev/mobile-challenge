package br.com.leonamalmeida.mobilechallenge.di

import br.com.leonamalmeida.mobilechallenge.data.source.remote.CurrencyLayerApi
import br.com.leonamalmeida.mobilechallenge.util.BASE_URL
import com.jakewharton.retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ApplicationComponent
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

/**
 * Created by Leo Almeida on 27/06/20.
 */

@Module
@InstallIn(ApplicationComponent::class)
object NetworkModule {

    @Singleton
    @Provides
    fun provideRetrofit(): Retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
        .client(
            OkHttpClient.Builder()
                .addInterceptor(
                    HttpLoggingInterceptor()
                        .apply { level = HttpLoggingInterceptor.Level.BODY })
                .build()
        )
        .build()

    @Singleton
    @Provides
    fun provideCurrencyService(): CurrencyLayerApi =
        provideRetrofit()
            .create(CurrencyLayerApi::class.java)
}