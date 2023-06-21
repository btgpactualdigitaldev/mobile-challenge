package com.btg.convertercurrency.data_local

import com.btg.convertercurrency.data_local.database.AppDatabase
import com.btg.convertercurrency.data_local.entity.CurrencyDb
import com.btg.convertercurrency.data_local.entity.QuoteDb
import com.btg.convertercurrency.features.base_entity.CurrencyItem
import com.btg.convertercurrency.features.base_entity.QuoteItem
import com.btg.convertercurrency.features.util.GenericConverterCurrencyException
import com.btg.convertercurrency.features.util.toOffsetDateTime
import kotlinx.coroutines.coroutineScope
import java.time.OffsetDateTime

class RepositoryCurrencyLayerLocal(db: AppDatabase) {

    private val currencyDao = db.currencyDao()
    private val quoteDao = db.quoteDao()

    suspend fun listCurrenciesWithQuoties(): List<CurrencyItem> = coroutineScope {
        currencyDao
            .getCurrencyWithQuote()
            .map {
                CurrencyItem().apply {
                    code = it.currencyDb.code
                    name = it.currencyDb.name
                    lastUpdate = it.currencyDb.lastUpdate
                    quotesList.addAll(it.quoteDb.map {
                        QuoteItem(
                            code = it.code,
                            quote = it.quote,
                            date = it.date,
                            currencyId = it.currencyDbId
                        )
                    })
                }
            }
    }

    suspend fun getCurrencyByCode(codeCurrency: String): CurrencyItem = coroutineScope {

        val currencyBdResult = currencyDao.getCurrencyWithQuoteByCode(codeCurrency)

        CurrencyItem().apply {
            code = currencyBdResult.currencyDb.code
            name = currencyBdResult.currencyDb.name
            lastUpdate = currencyBdResult.currencyDb.lastUpdate
            quotesList.addAll(currencyBdResult.quoteDb.map {
                QuoteItem(
                    code = it.code,
                    quote = it.quote,
                    date = it.date,
                    currencyId = it.currencyDbId
                )
            })
        }
    }

    suspend fun listCurrencies(): List<CurrencyItem> = coroutineScope {
       val list =  currencyDao.getCurrency()
            .map {CurrencyItem(code = it.code, name = it.name)}

        if(list.isEmpty()){
            throw GenericConverterCurrencyException(404,"A lista esta vazia.")
        }

        list
    }

    suspend fun insertCurrncy(currencyItemList: List<CurrencyItem>) {
        coroutineScope {
            currencyDao.insertAll(
                *currencyItemList
                    .map {
                        CurrencyDb(
                            name = it.name,
                            code = it.code,
                            id = it.name.hashCode().toLong(),
                            lastUpdate = it.lastUpdate
                        )
                    }
                    .toTypedArray())
        }
    }

    suspend fun insertQuoties(quoteItemList: List<QuoteItem>) {
        coroutineScope {
            quoteDao.insertAll(
                *quoteItemList
                    .map {
                        QuoteDb(
                            currencyDbId = it.currencyId,
                            code = it.code,
                            quote = it.quote,
                            date = it.date
                        )
                    }
                    .toTypedArray())
        }
    }

    suspend fun upDateFieldLastUpdate(timeLastUpdate: OffsetDateTime) {
        coroutineScope {
            currencyDao.updateFieldLastUpdate(timeLastUpdate)
        }
    }
}