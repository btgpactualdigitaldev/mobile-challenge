package com.btgpactual.currencyconverter.data.framework.retrofit

import br.com.albertomagalhaes.btgcurrencies.Constant
import br.com.albertomagalhaes.btgcurrencies.api.NetworkInterceptor
import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

class ClientAPI(val networkInterceptor: NetworkInterceptor) {

    val client: OkHttpClient = OkHttpClient.Builder().apply {
        this.addInterceptor(networkInterceptor)
    }.build()

    private fun initRetrofit(): Retrofit {
        return Retrofit.Builder()
            .baseUrl(Constant.BASE_URL)
            .addConverterFactory(
                MoshiConverterFactory.create(
                    Moshi.Builder()
                        .add(KotlinJsonAdapterFactory())
                        .build()
                )
            )
            .client(client)
            .build()
    }

    val endpointAPI: EndpointAPI = initRetrofit().create(EndpointAPI::class.java)

    sealed class ResponseType {
        class Success<T : Any>(val result : T? = null): ResponseType()
        sealed class Fail: ResponseType() {
            class NoInternet: Fail()
            class Unknown: Fail()
        }
    }

}