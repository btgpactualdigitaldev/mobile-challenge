package br.com.mobilechallenge.model.bean

import android.os.Parcelable

import kotlinx.android.parcel.Parcelize

@Parcelize
data class LiveBean(val id: Int,
                    val idCurrencies: Int?,
                    val code: String?,
                    val price: Double) : Parcelable