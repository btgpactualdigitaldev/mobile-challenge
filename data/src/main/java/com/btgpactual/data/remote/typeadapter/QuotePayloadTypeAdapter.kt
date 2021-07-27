package com.btgpactual.data.remote.typeadapter

import com.btgpactual.data.remote.model.QuoteModel
import com.btgpactual.data.remote.model.QuotePayload
import com.google.gson.JsonSerializer
import com.google.gson.TypeAdapter
import com.google.gson.stream.JsonReader
import com.google.gson.stream.JsonWriter

class QuotePayloadTypeAdapter : TypeAdapter<QuotePayload>() {

    override fun write(out: JsonWriter?, value: QuotePayload?) {}



    override fun read(reader: JsonReader): QuotePayload {
        val payloads = mutableListOf<QuoteModel>()
        reader.beginObject()
        while (reader.hasNext()){
            payloads.add(
                QuoteModel(
                    code = reader.nextName(),
                    value =  reader.nextDouble()
                )
            )
        }
        reader.endObject()
        return QuotePayload(payloads)
    }

}