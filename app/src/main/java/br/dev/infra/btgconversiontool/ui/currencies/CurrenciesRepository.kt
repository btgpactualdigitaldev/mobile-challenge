package br.dev.infra.btgconversiontool.ui.currencies

import br.dev.infra.btgconversiontool.data.CurrencyView
import br.dev.infra.btgconversiontool.room.CurrencyDatabaseDao
import javax.inject.Inject


class CurrenciesRepository @Inject constructor(
    private val currencyDatabaseDao: CurrencyDatabaseDao
) {

    suspend fun getCurrencies(): List<CurrencyView> = currencyDatabaseDao.getCurrencyQuotes()

}