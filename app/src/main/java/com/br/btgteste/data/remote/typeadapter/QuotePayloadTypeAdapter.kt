package com.br.btgteste.data.remote.typeadapter

import com.br.btgteste.data.model.QuotePayload
import com.br.btgteste.domain.model.Quote
import com.google.gson.TypeAdapter
import com.google.gson.stream.JsonReader
import com.google.gson.stream.JsonWriter

class QuotePayloadTypeAdapter: TypeAdapter<QuotePayload>() {

    override fun write(out: JsonWriter?, value: QuotePayload?) {}

    override fun read(reader: JsonReader): QuotePayload {
        val payloads = mutableListOf<Quote>()
        reader.beginObject()
        while (reader.hasNext()){
            payloads.add(
                Quote(
                    code = reader.nextName(),
                    value =  reader.nextDouble()
                )
            )
        }
        reader.endObject()
        return QuotePayload(payloads)
    }
}