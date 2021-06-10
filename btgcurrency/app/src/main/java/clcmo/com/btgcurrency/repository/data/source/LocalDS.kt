package clcmo.com.btgcurrency.repository.data.source

import clcmo.com.btgcurrency.repository.data.local.AppDB
import clcmo.com.btgcurrency.repository.data.local.entity.*
import clcmo.com.btgcurrency.util.Result
import clcmo.com.btgcurrency.util.Result.*
import clcmo.com.btgcurrency.util.exceptions.Exception

class LocalDS(db: AppDB) : DataSource {
    private val cDao = db.currencyDao()
    private val qDao = db.currencyQuoteDao()

    override suspend fun currencies(): Result<Map<String, String>> {
        val data = cDao.getCurrencies().map { it.id to it.name }.toMap()
        return when {
            data.isEmpty() -> Failure(Exception())
            else -> Success(data)
        }
    }

    override suspend fun quotes(): Result<Map<String, Float>> {
        val data = qDao.getQuotes().map { it.id to it.value }.toMap()
        return when {
            data.isEmpty() -> Failure(Exception())
            else -> Success(data)
        }
    }

    override fun saveC(mCurrencies: Map<String, String>) =
        cDao.saveCurrency(mCurrencies.map {
            CEntity.fromMapEntry(it)
        })

    override fun saveQ(mQuotes: Map<String, Float>) = qDao.saveQuote(mQuotes.map {
        QEntity.fromMapEntry(it)
    })
}

