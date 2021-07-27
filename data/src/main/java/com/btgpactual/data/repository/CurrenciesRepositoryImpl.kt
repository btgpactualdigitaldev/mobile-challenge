package com.btgpactual.data.repository

import com.btgpactual.data.local.source.CurrencyCacheDataSource
import com.btgpactual.data.remote.interactos.QuoteInteractor
import com.btgpactual.data.remote.source.ListRemoteDataSource
import com.btgpactual.data.remote.source.LiveRemoteDataSource
import com.btgpactual.domain.entity.Currency
import com.btgpactual.domain.repository.CurrenciesRepository
import io.reactivex.Single

class CurrenciesRepositoryImpl(
    private val apiKey: String,
    private val listRemoteDataSource: ListRemoteDataSource,
    private val liveRemoteDataSource: LiveRemoteDataSource,
    private val currencyCacheDataSource: CurrencyCacheDataSource
) : CurrenciesRepository{

    override fun getCurrencies(forceUpdate: Boolean): Single<List<Currency>> {
        return if (forceUpdate){
            getCurrencyRemote()
        }else{
            currencyCacheDataSource.getCurrencies()
                .flatMap {currencies ->
                    when{
                        currencies.isEmpty() -> getCurrencyRemote()
                        else -> Single.just(currencies)
                    }
                }
        }
    }

    override fun convert(amount: Double, from: Currency, to: Currency): Single<Double> {
        return liveRemoteDataSource.getLive(apiKey).map {
            QuoteInteractor.convert(amount,from,to,it)
        }
    }



    private fun getCurrencyRemote(): Single<List<Currency>> {
        return listRemoteDataSource.getCurrencies(apiKey)
            .flatMap { listJobs ->
                currencyCacheDataSource.updateData(listJobs)
                Single.just(listJobs)
            }
    }

}