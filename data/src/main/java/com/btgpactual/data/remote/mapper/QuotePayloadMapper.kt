package com.btgpactual.data.remote.mapper

import com.btgpactual.data.remote.model.QuoteModel
import com.btgpactual.domain.entity.Quote

object QuotePayloadMapper {
    fun map(payloads: List<QuoteModel>) = payloads.map { map(it) }

    private fun map(payload: QuoteModel) = Quote(
        code = payload.code,
        value = payload.value

    )
}