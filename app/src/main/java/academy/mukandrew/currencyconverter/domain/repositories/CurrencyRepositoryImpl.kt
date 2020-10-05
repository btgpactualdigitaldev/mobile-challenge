package academy.mukandrew.currencyconverter.domain.repositories

import academy.mukandrew.currencyconverter.commons.Result
import academy.mukandrew.currencyconverter.commons.Result.Failure
import academy.mukandrew.currencyconverter.commons.Result.Success
import academy.mukandrew.currencyconverter.commons.errors.NoContentException
import academy.mukandrew.currencyconverter.data.datasources.CurrencyDataSource
import academy.mukandrew.currencyconverter.domain.models.Currency
import academy.mukandrew.currencyconverter.domain.models.CurrencyQuote

class CurrencyRepositoryImpl(
    private val localDataSource: CurrencyDataSource,
    private val remoteDataSource: CurrencyDataSource
) : CurrencyRepository() {
    companion object {
        const val DEFAULT_QUANTITY_QUOTE_VALUE = 1f
    }

    override suspend fun list(): Result<List<Currency>> {
        try {
            val remoteResponse = remoteDataSource.list()
            if (remoteResponse is Success) {
                return Success(assembleCurrencyList(remoteResponse.data))
            }

            val localResponse = localDataSource.list()
            if (localResponse is Failure || (localResponse as Success).data.isEmpty()) {
                return (remoteResponse as? Failure) ?: Failure(NoContentException())
            }

            return Success(assembleCurrencyList(localResponse.data))
        } catch (e: Exception) {
            return Failure(e)
        }
    }

    override suspend fun assembleCurrencyList(currencyMap: Map<String, String>): List<Currency> {
        return currencyMap.map { Currency(it.key, it.value) }
    }

    override suspend fun quotes(): Result<List<CurrencyQuote>> {
        try {
            val remoteResponse = remoteDataSource.quotes()
            if (remoteResponse is Success) {
                return Success(assembleQuoteList(remoteResponse.data))
            }

            val localResponse = localDataSource.quotes()
            if (localResponse is Failure || (localResponse as Success).data.isEmpty()) {
                return (remoteResponse as? Failure) ?: Failure(NoContentException())
            }

            return Success(assembleQuoteList(localResponse.data))
        } catch (e: Exception) {
            return Failure(e)
        }
    }

    override suspend fun assembleQuoteList(quoteMap: Map<String, Float>): List<CurrencyQuote> {
        return quoteMap.map { CurrencyQuote(it.key, DEFAULT_QUANTITY_QUOTE_VALUE, it.value) }
    }
}