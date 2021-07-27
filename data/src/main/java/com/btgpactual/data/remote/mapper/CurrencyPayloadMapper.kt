package com.btgpactual.data.remote.mapper

import com.btgpactual.data.remote.model.CurrencyModel
import com.btgpactual.domain.entity.Currency

object CurrencyPayloadMapper {
    fun map(payloads: List<CurrencyModel>) = payloads.map { map(it) }

    private fun map(payload: CurrencyModel) = Currency(
        code = payload.code,
        name = payload.name

    )
}