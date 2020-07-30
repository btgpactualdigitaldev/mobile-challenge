package br.com.mobilechallenge.model.bean

import android.os.Parcelable

import kotlinx.android.parcel.Parcelize

@Parcelize
data class ListBean(val id: Int,
                    val code: String,
                    val description: String) : Parcelable