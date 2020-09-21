package br.com.leandrospidalieri.btgpactualconversion.network

import br.com.leandrospidalieri.btgpactualconversion.database.DatabaseCurrency
import br.com.leandrospidalieri.btgpactualconversion.domain.models.Currency
import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class CurrencyDTO(
    @Json(name = "success")
    val result: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: Map<String,String>
)

@JsonClass(generateAdapter = true)
data class QuotesDTO(
    @Json(name = "success")
    val result: Boolean,
    val terms: String,
    val privacy: String,
    val timestamp: Long,
    val source: String,
    val quotes: Map<String,Double>
)

fun CurrencyDTO.toCurrencyList(quotes:QuotesDTO):List<Currency>{
    return currencies.toList().map{
        Currency(
            code = it.first,
            description = it.second,
            quote = quotes.quotes.getValue("USD"+it.first)
        )
    }
}

fun CurrencyDTO.toCurrencyDatabaseList(quotes:QuotesDTO):Array<DatabaseCurrency>{
    return currencies.toList().map{
        DatabaseCurrency(
            code = it.first,
            description = it.second,
            quote = quotes.quotes.getValue("USD"+it.first)
        )
    }.toTypedArray()
}