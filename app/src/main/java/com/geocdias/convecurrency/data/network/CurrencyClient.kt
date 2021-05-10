package com.geocdias.convecurrency.data.network

import javax.inject.Inject

class CurrencyClient @Inject constructor(private val currencyApi: CurrencyApi): BaseDataSource() {
  suspend fun fetchCurrencies(apiKey: String) = getResult { currencyApi.fetchCurrencies(apiKey) }
  suspend fun fetchRates(accessKey: String) = getResult { currencyApi.fetchRates(accessKey ) }
}
