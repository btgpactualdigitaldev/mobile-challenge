package academy.mukandrew.currencyconverter.data.datasources

import academy.mukandrew.currencyconverter.commons.Result
import academy.mukandrew.currencyconverter.commons.errors.NoContentException
import academy.mukandrew.currencyconverter.data.local.entities.CurrencyEntity
import academy.mukandrew.currencyconverter.data.local.entities.CurrencyQuoteEntity
import academy.mukandrew.currencyconverter.data.local.room.AppDatabase

class CurrencyLocalDataSource(database: AppDatabase) : CurrencyDataSource() {
    private val currencyDao = database.currencyDao()
    private val currencyQuoteDao = database.currencyQuoteDao()

    override suspend fun list(): Result<Map<String, String>> {
        val data = currencyDao.getAll().map { it.code to it.name }.toMap()
        return when {
            data.isEmpty() -> Result.Failure(NoContentException())
            else -> Result.Success(data)
        }
    }

    override suspend fun saveCurrencies(currencies: Map<String, String>) {
        currencyDao.save(currencies.map { CurrencyEntity.fromMapEntry(it) })
    }

    override suspend fun quotes(): Result<Map<String, Float>> {
        val data = currencyQuoteDao.getAll().map { it.code to it.value }.toMap()
        return when {
            data.isEmpty() -> Result.Failure(NoContentException())
            else -> Result.Success(data)
        }
    }

    override suspend fun saveQuotes(quotes: Map<String, Float>) {
        currencyQuoteDao.save(quotes.map { CurrencyQuoteEntity.fromMapEntry(it) })
    }
}