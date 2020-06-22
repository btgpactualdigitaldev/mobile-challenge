package com.br.btgteste.data.remote.typeadapter

import com.br.btgteste.data.model.CurrencyPayload
import com.br.btgteste.domain.model.Currency
import com.google.gson.TypeAdapter
import com.google.gson.stream.JsonReader
import com.google.gson.stream.JsonWriter

class CurrenciesPayloadTypeAdapter : TypeAdapter<CurrencyPayload>() {

    override fun write(out: JsonWriter?, value: CurrencyPayload?) {}

    override fun read(reader: JsonReader): CurrencyPayload {
        val payloads = mutableListOf<Currency>()
        reader.beginObject()
        while (reader.hasNext()){
            payloads.add(
                Currency(
                    code = reader.nextName(),
                    name =  reader.nextString()
                )
            )
        }
        reader.endObject()
        return CurrencyPayload(payloads)
    }
}