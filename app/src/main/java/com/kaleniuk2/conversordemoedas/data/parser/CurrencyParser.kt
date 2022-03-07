package com.kaleniuk2.conversordemoedas.data.parser

import com.kaleniuk2.conversordemoedas.util.JSONUtil
import com.kaleniuk2.conversordemoedas.data.DataWrapper
import com.kaleniuk2.conversordemoedas.data.model.Currency
import org.json.JSONObject
import java.math.BigDecimal

object CurrencyParser {
    private const val ERROR_SEARCH = "Erro ao efetuar pesquisa"
    private const val ERROR_CONVERT = "Erro ao efetuar conversão"
    fun toListCurrencies(responseJSONObject: JSONObject): DataWrapper<List<Currency>?> {
        return if (responseJSONObject.getBoolean("success")) {
            try {
                val map =
                    JSONUtil.toMap(responseJSONObject.getJSONObject("currencies")) as Map<String, String>
                val listCurrency = mutableListOf<Currency>()

                map.forEach { item ->
                    listCurrency.add(Currency(item.value, item.key))
                }

                DataWrapper.Success(listCurrency)

            } catch (e: Exception) {
                DataWrapper.Error(ERROR_SEARCH)
            }
        } else {
            DataWrapper
                .Error(responseJSONObject.getJSONObject("error").getString("info"))
        }
    }

    fun toQuotes(responseJSONObject: JSONObject): DataWrapper<List<Currency>?> {
        return if (responseJSONObject.getBoolean("success")) {
            try {
                val map =
                    JSONUtil.toMap(responseJSONObject.getJSONObject("quotes")) as Map<String, Double>
                val listCurrency = mutableListOf<Currency>()

                map.forEach { item ->
                    listCurrency.add(Currency("", item.key, BigDecimal.valueOf(item.value)))
                }

                DataWrapper.Success(listCurrency)

            } catch (e: Exception) {
                DataWrapper.Error(ERROR_CONVERT)
            }
        } else {
            DataWrapper
                .Error(responseJSONObject.getJSONObject("error").getString("info"))
        }
    }
}