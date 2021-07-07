package br.com.leonamalmeida.mobilechallenge.data.source.remote

import br.com.leonamalmeida.mobilechallenge.data.Currency
import io.reactivex.Single

/**
 * Created by Leo Almeida on 27/06/20.
 */

interface CurrencyRemoteDataSource {

    fun getCurrencies(): Single<List<Currency>>
}

class CurrencyRemoteDataSourceImpl(private val service: CurrencyLayerApi) :
    CurrencyRemoteDataSource {

    override fun getCurrencies(): Single<List<Currency>> =
        service.getAvailableCurrencies()
            .map { response -> response.currencyMap() }
}
