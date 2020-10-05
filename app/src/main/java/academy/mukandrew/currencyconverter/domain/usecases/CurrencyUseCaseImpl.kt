package academy.mukandrew.currencyconverter.domain.usecases

import academy.mukandrew.currencyconverter.commons.Result
import academy.mukandrew.currencyconverter.commons.Result.Failure
import academy.mukandrew.currencyconverter.commons.Result.Success
import academy.mukandrew.currencyconverter.domain.models.Currency
import academy.mukandrew.currencyconverter.domain.models.CurrencyQuote
import academy.mukandrew.currencyconverter.domain.repositories.CurrencyRepository

class CurrencyUseCaseImpl(private val repository: CurrencyRepository) : CurrencyUseCase() {
    companion object {
        const val QUOTE_USD_NAME_INDEX = 3
        const val QUANTITY_TO_NOT_CALC = 0f
    }

    override suspend fun list(): Result<List<Currency>> {
        val currencies = repository.list()
        if (currencies is Failure) return currencies
        val quotes = repository.quotes()
        if (quotes is Failure) return quotes

        return Success(assembleCurrencyList((currencies as Success).data, (quotes as Success).data))
    }

    private fun assembleCurrencyList(
        currencies: List<Currency>,
        quotes: List<CurrencyQuote>
    ): List<Currency> {
        return currencies.mapNotNull { currency ->
            getQuoteByCode(currency.code, quotes)?.let { currencyQuote ->
                currency.apply { quote = currencyQuote }
            }
        }
    }

    override fun getQuoteByCode(currencyCode: String, quotes: List<CurrencyQuote>): CurrencyQuote? {
        return quotes.firstOrNull { currencyCode in it.code.substring(QUOTE_USD_NAME_INDEX) }
    }

    override suspend fun convert(
        quantity: Float,
        fromCurrency: Currency,
        toCurrency: Currency
    ): Result<Float> {
        if (!quantity.isFinite() && quantity <= QUANTITY_TO_NOT_CALC) return Failure(Exception())

        val fromValue = fromCurrency.quote?.value ?: return Failure(Exception())
        val toValue = toCurrency.quote?.value ?: return Failure(Exception())
        val result = (quantity / fromValue) * toValue
        return Success(result)
    }

}