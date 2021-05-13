package com.btg.convertercurrency.data_network.server.endpoints.serializers

import com.btg.convertercurrency.data_network.server.endpoints.response.QuotesResponse
import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import java.lang.reflect.Type

class JsonDeserializerQuoteAdapter : JsonDeserializer<MutableList<QuotesResponse>> {

    override fun deserialize(
        json: JsonElement,
        typeOfT: Type,
        ctx: JsonDeserializationContext
    ): MutableList<QuotesResponse> {
        return json
            .asJsonObject
            .entrySet()
            .map {
                QuotesResponse(
                    code = it.key.toString(),
                    quote = it.value.asString
                )
            } as MutableList<QuotesResponse>
    }
}