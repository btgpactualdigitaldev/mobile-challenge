package com.lucasnav.desafiobtg.modules.currencyConverter.networking

import android.annotation.SuppressLint
import com.lucasnav.desafiobtg.core.network.BaseNetwork
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Quote
import com.lucasnav.desafiobtg.modules.currencyConverter.model.RequestError
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

object CurrencyNetworking : BaseNetwork() {

    private val API by lazy { getRetrofitBuilder().build().create(CurrencyApi::class.java) }

    @SuppressLint("CheckResult")
    fun getCurrenciesFromApi(
        onSuccess: (currencieResponse: List<Currency>) -> Unit,
        onError: (error: RequestError) -> Unit
    ) {
        API.getCurrenciesFromApi()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({

                if (it.success) {
                    val currencies = it.currencies?.map {
                        Currency(0, it.key, it.value)
                    }

                    if (currencies != null) {
                        onSuccess(currencies)
                    }
                } else {
                    val error = RequestError(it.error.code, it.error.info)
                    onError(error)
                }

            }, {
                val error = RequestError(-1, it.message.toString())
                onError(error)
            })
    }

    @SuppressLint("CheckResult")
    fun getQuotesFromApi(
        firsCurrency: String,
        secondCurrency: String,
        onSuccess: (quotesResponse: List<Quote>) -> Unit,
        onError: (error: RequestError) -> Unit
    ) {

        val currencies = if (firsCurrency.isNotEmpty()) "${firsCurrency},${secondCurrency}" else ""

        API.getQuotesFromApi(currencies)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({ quotesResponse ->
                quotesResponse.let {

                    if (it.success) {
                        val quotes = it.quotes?.map {
                            Quote(
                                0,
                                it.key,
                                it.value
                            )
                        }

                        if (quotes != null) {
                            onSuccess(quotes)
                        }
                    } else {
                        val error = RequestError(it.error.code, it.error.info)
                        onError(error)
                    }
                }
            }, { error ->
                onError(RequestError(-1, error.message.toString()))
            })
    }
}