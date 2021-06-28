package br.com.gft.main.iteractor.model

import br.com.gft.main.service.model.CurrencyListResponse
import br.com.gft.main.service.model.CurrencyResponse
import java.io.Serializable

data class Currency(val code: String, val name:String): Serializable
{
    companion object {
        fun listFromResponse(currencyListResponse: HashMap<String,String>): List<Currency> =
            currencyListResponse.map {
                Currency(it.key,it.value)
            }

        fun fromResponse(currencyResponse: CurrencyResponse): Currency =
            Currency(
                currencyResponse.code,
                currencyResponse.name
            )
    }
}
