package br.com.daccandido.currencyconverterapp.data.model

import android.os.Parcelable
import io.realm.RealmObject
import io.realm.annotations.PrimaryKey
import io.realm.annotations.RealmClass
import kotlinx.android.parcel.Parcelize
import java.text.NumberFormat
import java.util.*

@Parcelize
@RealmClass
open class Quote(
    @PrimaryKey var id: Long = 0,
    var code: String = "",
    var quote: Double = 0.0

) : RealmObject(), Parcelable