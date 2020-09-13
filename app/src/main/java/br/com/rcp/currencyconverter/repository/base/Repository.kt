package br.com.rcp.currencyconverter.repository.base

import br.com.rcp.currencyconverter.Converter
import br.com.rcp.currencyconverter.Result
import br.com.rcp.currencyconverter.database.CurrencyDB
import br.com.rcp.currencyconverter.utils.APIService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

abstract class Repository {
    protected val service : APIService by lazy { Converter.component.getServiceAPI() }
    protected val storage : CurrencyDB by lazy { Converter.component.getCurrenciesDatabase() }

    protected suspend fun <T> handle(call: suspend () -> T) : Result<T> {
        return withContext(Dispatchers.IO) {
            try {
                Result.Success(call.invoke())
            } catch (exception: Exception) {
                Result.Failure(exception)
            }
        }
    }
}