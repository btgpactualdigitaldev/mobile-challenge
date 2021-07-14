package com.sugarspoon.data.local.repositories

import com.sugarspoon.data.local.dao.CurrencyDao
import com.sugarspoon.data.local.dao.QuotationDao
import com.sugarspoon.data.local.entity.CurrencyEntity
import com.sugarspoon.data.local.entity.QuotationEntity
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers.IO
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.launch

class RepositoryLocal(
    private val currencyDao: CurrencyDao,
    private val quotationDao: QuotationDao
) {

    val allCurrencies: Flow<List<CurrencyEntity>> = currencyDao.getAll()

    fun getCurrencyByName(name: String): CurrencyEntity {
        return currencyDao.getCurrencyByName(name)
    }

    fun insertCurrency(currency: CurrencyEntity) {
        CoroutineScope(IO).launch {
            currencyDao.insertAll(currency)
        }
    }

    fun deleteCurrency() {
        CoroutineScope(IO).launch {
            currencyDao.delete()
        }
    }

    val allQuotations: Flow<List<QuotationEntity>> = quotationDao.getAll()

    fun getQuotationByCode(code: String): Flow<QuotationEntity> {
        return quotationDao.findQuotationByCode(code)
    }

    fun insertQuotation(quotation: QuotationEntity) {
        CoroutineScope(IO).launch {
            quotationDao.insertAll(quotation)
        }
    }

    fun deleteQuotation() {
        CoroutineScope(IO).launch {
            quotationDao.delete()
        }
    }
}