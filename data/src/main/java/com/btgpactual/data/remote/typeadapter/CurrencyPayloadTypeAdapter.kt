package com.btgpactual.data.remote.typeadapter

import com.btgpactual.data.remote.model.CurrencyModel
import com.btgpactual.data.remote.model.CurrencyPayload
import com.google.gson.TypeAdapter
import com.google.gson.stream.JsonReader
import com.google.gson.stream.JsonWriter

class CurrencyPayloadTypeAdapter : TypeAdapter<CurrencyPayload>() {


    override fun write(out: JsonWriter?, value: CurrencyPayload?) {
    }

    override fun read(reader: JsonReader): CurrencyPayload {
        val payloads = mutableListOf<CurrencyModel>()
        reader.beginObject()
        while (reader.hasNext()){
            payloads.add(
                CurrencyModel(
                    code = reader.nextName(),
                    name =  reader.nextString()
                )
            )
        }
        reader.endObject()
        return CurrencyPayload(payloads)
    }


}