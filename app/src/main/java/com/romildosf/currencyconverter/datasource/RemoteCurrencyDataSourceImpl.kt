package com.romildosf.currencyconverter.datasource

import com.romildosf.currencyconverter.dao.Currency
import com.romildosf.currencyconverter.dao.Quotation
import com.romildosf.currencyconverter.datasource.rest.CurrencyService
import com.romildosf.currencyconverter.util.BaseException
import com.romildosf.currencyconverter.util.NetworkCallException
import com.romildosf.currencyconverter.util.UnknownException
import com.romildosf.currencyconverter.util.UnreachableNetworkException
import retrofit2.HttpException
import java.lang.Exception
import java.net.ConnectException
import java.net.UnknownHostException

class RemoteCurrencyDataSourceImpl(private val service: CurrencyService): RemoteCurrencyDataSource {

    override suspend fun fetchCurrencies(): List<Currency> {
        try {
            val response = service.fetchList()
            if (response.success) return response.currencies
            throw NetworkCallException(response.error!!.code.toString(), response.error.info)
        } catch (exception: Exception) {
            throw convertException(exception)
        }
    }

    override suspend fun fetchQuotes(): List<Quotation> {
        try {
            val response = service.fetchCurrencyQuotes()
            if (response.success) return response.quotes
            throw NetworkCallException(response.error!!.code.toString(), response.error.info)
        } catch (exception: Exception) {
            throw convertException(exception)
        }
    }

    private fun convertException(exception: Exception): BaseException {
        return when (exception) {
            is ConnectException,
            is UnknownHostException -> UnreachableNetworkException
            is HttpException -> NetworkCallException(exception.code().toString(), exception.message())
            is BaseException -> exception
            else -> UnknownException(exception.message ?: "")
        }
    }
}