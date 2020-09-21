package br.com.leandrospidalieri.btgpactualconversion.network

import br.com.leandrospidalieri.btgpactualconversion.BuildConfig
import com.jakewharton.retrofit2.adapter.kotlin.coroutines.CoroutineCallAdapterFactory
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import kotlinx.coroutines.Deferred
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import retrofit2.converter.scalars.ScalarsConverterFactory
import retrofit2.http.GET

private const val BASE_URL = "http://api.currencylayer.com"
private const val API_KEY = BuildConfig.API_KEY

interface CurrencyApiService{
    @GET("list?access_key=$API_KEY")
    fun getCurrenciesAsync(): Deferred<CurrencyDTO>

    @GET("live?access_key=$API_KEY")
    fun getQuotesAsync(): Deferred<QuotesDTO>
}

private val moshi = Moshi.Builder()
    .add(KotlinJsonAdapterFactory())
    .build()


object Network{
    private val retrofit = Retrofit.Builder()
        .addConverterFactory(MoshiConverterFactory.create(moshi))
        .addCallAdapterFactory(CoroutineCallAdapterFactory())
        .baseUrl(BASE_URL)
        .build()

    val currencyApi = retrofit.create(CurrencyApiService::class.java)
}