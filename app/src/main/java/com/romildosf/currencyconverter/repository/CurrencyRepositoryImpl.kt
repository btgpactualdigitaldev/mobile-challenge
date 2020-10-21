package com.romildosf.currencyconverter.repository

import android.util.Log
import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.dao.Quotation
import com.romildosf.currencyconverter.datasource.LocalCurrencyDataSource
import com.romildosf.currencyconverter.datasource.RemoteCurrencyDataSource
import com.romildosf.currencyconverter.util.*

class CurrencyRepositoryImpl(
    private val remoteDataSource: RemoteCurrencyDataSource,
    private val localDataSource: LocalCurrencyDataSource
) : CurrencyRepository {

    override suspend fun fetchCurrencyList(): Result<List<Currency>> {
        return try {
            val t = System.currentTimeMillis()
            val currencies = remoteDataSource.fetchCurrencies()
            syncLocalCurrencies(currencies)
            Log.e("REPO", "Waiting for persist? ${System.currentTimeMillis() -t }ms")
            Result.Success(currencies)
        } catch (exception: Exception) {
            Log.e("REPO", "Error ", exception)
            if (exception is NetworkCallException)
                getLocalCurrencies(exception)
            else Result.Failure(exception)
        }
    }

    override suspend fun fetchCurrencyQuotation(source: String, target: String): Result<Quotation> {
        return try {
            val quotes = remoteDataSource.fetchQuotes()
            syncLocalQuotes(quotes)
            calculateTargetOverSource(quotes, source, target)
        } catch (exception: Exception) {
            Log.e("REPO", "Error ", exception)

            if (exception is NetworkCallException)
                findQuotationLocally(exception, source, target)
            else Result.Failure(exception)
        }
    }

    private suspend fun getLocalCurrencies(exception: NetworkCallException): Result<List<Currency>> {
        return try {
            val currencies = localDataSource.getCurrencies()
            if (currencies.isEmpty()) Result.Failure(exception)
            else Result.Success(currencies)
        } catch (exception: Exception) {
            Result.Failure(UnknownException(exception.message ?: ""))
        }
    }

    private suspend fun findQuotationLocally(exception: Exception, source: String, target: String): Result<Quotation> {
        return try {
            val quotes = localDataSource.getQuotes()
            if (quotes.isEmpty()) Result.Failure(exception)
            else calculateTargetOverSource(quotes, source, target)
        } catch (exception: Exception) {
            Result.Failure(UnknownException(exception.message ?: ""))
        }
    }

    private fun calculateTargetOverSource(quotes: List<Quotation>, source: String, target: String): Result<Quotation> {
        if (source == "USD") {
            val usdQuotation = quotes.find { it.pair == "$source$target" }
                ?: return Result.Failure(CurrencyNotFoundException)

            return Result.Success(usdQuotation)
        }
        val usdQuotes = quotes.filter { it.pair == "USD$source" || it.pair == "USD$target" }
        val sourceValue = usdQuotes.find { it.pair.contains(source) }
        val targetValue = usdQuotes.find { it.pair.contains(target) }

        if (sourceValue == null || targetValue == null)
            return Result.Failure(CurrencyNotFoundException)

        val targetOverSourceValue = targetValue.value / sourceValue.value
        return Result.Success(Quotation("$source$target", targetOverSourceValue))
    }

    private suspend fun syncLocalCurrencies(currencies: List<Currency>) {
        val remoteCurrencies = currencies.asMap() // transforming in a map for better performance
        val localCurrencies = localDataSource.getCurrencies().asMap()

        val t = System.currentTimeMillis()
        val toBeInserted = remoteCurrencies.filterNot { localCurrencies.containsKey(it.key) } // in case that currency isn't in the DB
        val toBeRemoved  = localCurrencies.filterNot { remoteCurrencies.containsKey(it.key) } // in case that no longer exists in API, but is in DB
        val toBeUpdated  = remoteCurrencies.filter { localCurrencies.containsKey(it.key) // in case that currency fullName has changed
                    && localCurrencies[it.key]?.fullName != it.value.fullName }

        Log.e("REPOSITORY", "syncLocalCurrencies Filtering Takes ${System.currentTimeMillis() - t}ms")


        with(localDataSource) {
            Log.e("REPOSITORY", "syncLocalCurrencies toBeInserted $toBeInserted")
            Log.e("REPOSITORY", "syncLocalCurrencies toBeUpdated $toBeUpdated")
            Log.e("REPOSITORY", "syncLocalCurrencies toBeRemoved $toBeRemoved")

            if (toBeInserted.isNotEmpty()) insertCurrencies(toBeInserted.values.toList())
            if (toBeUpdated.isNotEmpty()) updateCurrencies(toBeUpdated.values.toList())
            if (toBeRemoved.isNotEmpty()) deleteCurrencies(toBeRemoved.values.toList())
        }

        Log.e("REPOSITORY", "syncLocalCurrencies ALL Takes ${System.currentTimeMillis() - t}ms")
    }

    private suspend fun syncLocalQuotes(quotes: List<Quotation>) {
            val t = System.currentTimeMillis()
        val remoteQuotes = quotes.asMap() // transforming in a map for better performance
        val localQuotes = localDataSource.getQuotes().asMap()

        // in case that currency isn't in the DB
        val toBeInserted = remoteQuotes.filterNot { localQuotes.containsKey(it.key) }

        // in case that no longer exists in API, but is in DB
        val toBeRemoved  = localQuotes.filterNot { remoteQuotes.containsKey(it.key) }

        // in case that currency fullName has changed
        val toBeUpdated  = localQuotes.filter { remoteQuotes.containsKey(it.key)
                && remoteQuotes[it.key]?.value != it.value.value
        }

        with(localDataSource) {
            if (toBeInserted.isNotEmpty()) insertQuotes(toBeInserted.values.toList())
            if (toBeUpdated.isNotEmpty()) updateQuotes(toBeUpdated.values.toList())
            if (toBeRemoved.isNotEmpty()) deleteQuotes(toBeRemoved.values.toList())
        }

        Log.e("REPOSITORY", "syncLocalQuotes Takes ${System.currentTimeMillis() - t}ms")
    }
}