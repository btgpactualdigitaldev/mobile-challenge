package br.net.easify.currencydroid.api

import br.net.easify.currencydroid.api.interfaces.ICurrency
import br.net.easify.currencydroid.api.model.Currency
import br.net.easify.currencydroid.api.util.RetrofitBuilder
import io.reactivex.Single

class CurrencyService {

    private val api = RetrofitBuilder().retrofit()
        .create(ICurrency::class.java)

    fun list(): Single<Currency> {
        return api.list()
    }
}