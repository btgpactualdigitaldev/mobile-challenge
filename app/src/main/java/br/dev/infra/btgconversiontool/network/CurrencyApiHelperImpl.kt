package br.dev.infra.btgconversiontool.network

import br.dev.infra.btgconversiontool.data.CurrencyList
import br.dev.infra.btgconversiontool.data.CurrencyQuotes
import javax.inject.Inject

class CurrencyApiHelperImpl @Inject constructor(
    private val currencyApiInterface: CurrencyApiInterface
) : CurrencyApiHelper {
    override suspend fun getListApi(): CurrencyList =
        currencyApiInterface.getListApi()


    override suspend fun getQuotesApi(): CurrencyQuotes =
        currencyApiInterface.getQuotesApi()

}