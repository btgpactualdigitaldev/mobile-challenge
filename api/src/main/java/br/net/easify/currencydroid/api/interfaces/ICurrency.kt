package br.net.easify.currencydroid.api.interfaces

import br.net.easify.currencydroid.api.model.Currency
import io.reactivex.Single
import retrofit2.http.GET

interface ICurrency {
    @GET("list")
    fun list(): Single<Currency>
}