package br.net.easify.currencydroid.api

import br.net.easify.currencydroid.api.interfaces.IQuote
import br.net.easify.currencydroid.api.model.Quote
import br.net.easify.currencydroid.api.util.RetrofitBuilder
import io.reactivex.Single

class QuoteService {

    private val api = RetrofitBuilder().retrofit()
        .create(IQuote::class.java)

    fun live(): Single<Quote> {
        return api.live()
    }
}