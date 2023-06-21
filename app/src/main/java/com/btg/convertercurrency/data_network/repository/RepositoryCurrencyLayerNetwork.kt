package com.btg.convertercurrency.data_network.repository

import android.content.Context
import com.btg.convertercurrency.R
import com.btg.convertercurrency.data_network.server.RetrofitInitializer
import com.btg.convertercurrency.data_network.server.endpoints.response.*
import com.btg.convertercurrency.data_network.server.endpoints.serializers.JsonDeserializerCurrencyAdapter
import com.btg.convertercurrency.data_network.server.endpoints.serializers.JsonDeserializerQuoteAdapter
import com.btg.convertercurrency.features.base_entity.CurrencyItem
import com.btg.convertercurrency.features.base_entity.QuoteItem
import com.btg.convertercurrency.features.util.GenericConverterCurrencyException
import com.btg.convertercurrency.features.util.toOffsetDateTime
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import kotlinx.coroutines.coroutineScope

class RepositoryCurrencyLayerNetwork(val context: Context) {

    private val retrofitInitializer =
        RetrofitInitializer.getService(RetrofitInitializer.Servers.CurrencyLayer_API)

    suspend fun listCurrencies(): List<CurrencyItem> {

        return coroutineScope {
//            online
            val response = retrofitInitializer.listCurrencie()

            val listResult = mutableListOf<CurrencyItem>()

            if (response.success) {
                listResult.addAll(
                    response.currencies.map { CurrencyItem(name = it.name, code = it.code) })
            } else {
                throw GenericConverterCurrencyException(
                    response.errorResponse.code,
                    response.errorResponse.info
                )
            }

            listResult
        }
    }

    suspend fun listQuotes(): List<QuoteItem> {

        return coroutineScope {

            val quotesObjectResponse = retrofitInitializer.listQuotes()

            val listResult = mutableListOf<QuoteItem>()

            if (quotesObjectResponse.success) {
                listResult.addAll(
                    quotesObjectResponse
                        .quotes
                        .map {
                            QuoteItem(
                                quote = it.quote,
                                code = it.code.replaceFirst(quotesObjectResponse.source, ""),
                                date = quotesObjectResponse.timeStamp.toLong().toOffsetDateTime()
                            )
                        })
            } else {
                throw GenericConverterCurrencyException(
                    quotesObjectResponse.errorResponse.code,
                    quotesObjectResponse.errorResponse.info
                )
            }

            listResult


        }
    }

    private fun getLocalCurrencyResponse(): CurrencyObjectResponse {
        //          local
//            getLocalCurrencyResponse()
        //                .currencies.map { CurrencyItem(name = it.name, code = it.code) }

        val jsonString = context
            .resources
            .openRawResource(R.raw.currency_list_response)
            .bufferedReader()
            .use { it.readText() }

        val listType = object : TypeToken<MutableList<CurrenciesResponse>>() {}.type

        return GsonBuilder()
            .registerTypeAdapter(
                listType,
                JsonDeserializerCurrencyAdapter()
            )
            .create()
            .fromJson(jsonString, CurrencyObjectResponse::class.java)
    }

    private fun getLocalQuoteResponse() {
        val jsonString = context
            .resources
            .openRawResource(R.raw.quotes_list_response)
            .bufferedReader()
            .use { it.readText() }

        val listType = object : TypeToken<MutableList<QuotesResponse>>() {}.type

        val quotesObjectResponse = GsonBuilder()
            .registerTypeAdapter(
                listType,
                JsonDeserializerQuoteAdapter()
            )
            .create()
            .fromJson(jsonString, QuotesObjectResponse::class.java)

        val respose = quotesObjectResponse

        respose
            .quotes
            .map {
                QuoteItem(
                    quote = it.quote, code = it.code.replaceFirst(respose.source, ""),
                    date = respose.timeStamp.toLong().toOffsetDateTime()
                )
            }
    }
}