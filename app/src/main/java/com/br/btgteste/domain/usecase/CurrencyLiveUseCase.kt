package com.br.btgteste.domain.usecase

import com.br.btgteste.data.model.CurrencyLiveDTO
import com.br.btgteste.domain.helper.QuotesHelper
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.repository.CurrenciesRepository

class CurrencyLiveUseCase(
    private val currenciesRepository: CurrenciesRepository):
    BaseUseCase<CurrencyLiveUseCase.Params, Double>() {

    data class Params(val amount: Double, val from : Currency, val to : Currency)

    override suspend fun executeAsyncTasks(request: Params): ApiResult<Double> {
        val response = runAsync { currenciesRepository.convertCurrencies() }.await()
        if (response.success) {
            return ApiResult.Success(convertResponse(request, response))
        } else {
            throw Throwable(response.error?.info)
        }
    }

    internal fun convertResponse(request: Params, response: CurrencyLiveDTO) : Double = QuotesHelper.convert(
        request.amount, request.from, request.to, response.quotes.payloads)
}
