package com.br.btgteste.data.model

import android.os.Parcelable
import com.br.btgteste.domain.model.Quote
import kotlinx.android.parcel.Parcelize

@Parcelize
data class QuotePayload(
    val payloads : List<Quote>
): Parcelable
