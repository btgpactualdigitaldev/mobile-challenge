package com.lucasnav.desafiobtg.modules.currencyConverter.interactor

import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.model.RequestError
import com.lucasnav.desafiobtg.modules.currencyConverter.repository.CurrencyRepository
import java.math.BigDecimal
import java.math.RoundingMode

open class CurrencyInteractor(
    private val currencyRepository: CurrencyRepository
) {

    fun getQuotesAndCalculateAmount(
        amount: String,
        firstCurrency: String,
        secondCurrency: String,
        onSuccess: (result: BigDecimal) -> Unit,
        onError: (error: RequestError) -> Unit
    ) {
        currencyRepository.getQuotes(
            firstCurrency,
            secondCurrency,
            onSuccess = { quotes ->
                val result = (quotes[1].value / quotes[0].value).times(amount.toDouble())
                val roundedResult = result.toBigDecimal().setScale(3, RoundingMode.UP)
                onSuccess(roundedResult)
            },
            onError = { onError(it) }
        )
    }

    fun getCurrencies(
        onSuccess: (currencies: List<Currency>) -> Unit,
        onError: (error: RequestError) -> Unit
    ) {
        currencyRepository.getCurrencies(
            onSuccess = { onSuccess(it) },
            onError = { onError(it) }
        )
    }

    fun searchCurrencies(
        query: String,
        onSuccess: (currencies: List<Currency>) -> Unit,
        onError: (error: RequestError) -> Unit
    ) {
        currencyRepository.searchCurrencies(
            query,
            onSuccess = { onSuccess(it) },
            onError = {
                val error = RequestError(-1, it)
                onError(error)
            }
        )
    }

    fun getAllQuotesFromApiAndSave() {
        currencyRepository.getAllQuotesFromApiAndSave()
    }
}