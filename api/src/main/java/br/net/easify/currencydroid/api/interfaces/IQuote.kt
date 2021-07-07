package br.net.easify.currencydroid.api.interfaces

import br.net.easify.currencydroid.api.model.Quote
import io.reactivex.Single
import retrofit2.http.GET

interface IQuote {
    @GET("live")
    fun live(): Single<Quote>
}