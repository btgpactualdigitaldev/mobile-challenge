package com.br.btgteste.data.model

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class CurrencyLiveDTO(val success : Boolean,
                           val terms : String?,
                           val privacy : String?,
                           val timeStamp : String?,
                           val source : String?,
                           val quotes : QuotePayload,
                           val error: ErrorPayload?) : Parcelable