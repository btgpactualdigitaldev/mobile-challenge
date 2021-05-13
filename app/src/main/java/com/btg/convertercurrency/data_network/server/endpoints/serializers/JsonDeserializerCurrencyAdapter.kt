package com.btg.convertercurrency.data_network.server.endpoints.serializers

import com.btg.convertercurrency.data_network.server.endpoints.response.CurrenciesResponse
import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import java.lang.reflect.Type

class JsonDeserializerCurrencyAdapter: JsonDeserializer<MutableList<CurrenciesResponse>> {


    override fun deserialize(json: JsonElement, typeOfT: Type, ctx: JsonDeserializationContext): MutableList<CurrenciesResponse> {
        return json.asJsonObject.entrySet().map {
            CurrenciesResponse(
                code = it.key.toString(),
                name = it.value.asString
            )
        } as MutableList<CurrenciesResponse>
    }
}