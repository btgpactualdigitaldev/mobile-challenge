package br.dev.infra.btgconversiontool.network

import br.dev.infra.btgconversiontool.data.CurrencyList
import br.dev.infra.btgconversiontool.data.CurrencyQuotes

interface CurrencyApiHelper {
    suspend fun getListApi(): CurrencyList
    suspend fun getQuotesApi(): CurrencyQuotes
}