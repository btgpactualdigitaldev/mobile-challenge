package com.br.btgteste.data.model

import android.os.Parcelable
import com.br.btgteste.domain.model.Currency
import kotlinx.android.parcel.Parcelize

@Parcelize
data class CurrencyPayload(
    val payloads : List<Currency>
): Parcelable