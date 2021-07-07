package br.com.leonamalmeida.mobilechallenge.data.source.remote

import br.com.leonamalmeida.mobilechallenge.data.Rate
import io.reactivex.Single

/**
 * Created by Leo Almeida on 29/06/20.
 */

interface RateRemoteDataSource {

    fun getRealTimeRate(): Single<List<Rate>>
}

class RateRemoteDataSourceImpl(private val service: CurrencyLayerApi) :
    RateRemoteDataSource {

    override fun getRealTimeRate(): Single<List<Rate>> =
        service.getRealTimeRate()
            .map { response -> response.rateMap() }
}