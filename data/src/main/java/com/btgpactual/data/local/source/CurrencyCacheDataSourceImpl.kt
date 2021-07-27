package com.btgpactual.data.local.source

import com.btgpactual.data.local.database.CurrencyCacheDao
import com.btgpactual.data.local.mapper.CurrencyCacheMapper
import com.btgpactual.domain.entity.Currency
import io.reactivex.Single

class CurrencyCacheDataSourceImpl(
    private val currencyCacheDao: CurrencyCacheDao
) : CurrencyCacheDataSource{

    override fun getCurrencies(): Single<List<Currency>> {
        return currencyCacheDao.getCurrencies().map { CurrencyCacheMapper.map(it) }
    }

    override fun insertData(currencies: List<Currency>) {
        currencyCacheDao.insertAll(currencies = CurrencyCacheMapper.mapCurrencyToCurrencyCache(currencies))
    }

    override fun updateData(currencies: List<Currency>) {
        currencyCacheDao.updateData(CurrencyCacheMapper.mapCurrencyToCurrencyCache(currencies))
    }

}
