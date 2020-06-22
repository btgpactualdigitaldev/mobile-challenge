package com.br.btgteste.domain.usecase

import com.br.btgteste.domain.datasource.CurrencyDataSource
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.repository.CurrenciesRepository

class CurrencyListUseCase(
    private val currenciesRepository: CurrenciesRepository,
    private val currencyDataSource: CurrencyDataSource
): BaseUseCase<Any, List<Currency>>() {

    override suspend fun executeAsyncTasks(request: Any): ApiResult<List<Currency>> {
        val currencies = currencyDataSource.getCurrencies()
        return if (currencies.isEmpty()) {
            val response =
                runAsync { currenciesRepository.getCurrencies() }.await()
            if (response.success) {
                currencyDataSource.updateCurrencies(response.currencies.payloads)
                ApiResult.Success(response.currencies.payloads)
            } else {
                throw Throwable(response.error?.info)
            }
        } else {
            ApiResult.Success(currencies)
        }
    }
}
