package br.com.leonamalmeida.mobilechallenge.data.source.local

import br.com.leonamalmeida.mobilechallenge.data.source.local.dao.RateDao
import br.com.leonamalmeida.mobilechallenge.data.Rate
import io.reactivex.Completable
import io.reactivex.Flowable

/**
 * Created by Leo Almeida on 29/06/20.
 */

interface RateLocalDataSource {
    fun getRealTimeRate(): Flowable<List<Rate>>

    fun getRateByCode(code: String): Rate

    fun saveRates(rates: List<Rate>): Completable
}

class RateLocalDataSourceImpl(private val rateDao: RateDao) :
    RateLocalDataSource {

    override fun getRealTimeRate(): Flowable<List<Rate>> = rateDao.getRates()

    override fun getRateByCode(code: String): Rate = rateDao.getRateByCode(code)

    override fun saveRates(rates: List<Rate>): Completable = rateDao.insertRates(rates)
}