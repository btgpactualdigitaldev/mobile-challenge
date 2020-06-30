package br.com.daccandido.currencyconverterapp.data.model

import android.os.Parcelable
import io.realm.RealmObject
import io.realm.annotations.PrimaryKey
import io.realm.annotations.RealmClass
import kotlinx.android.parcel.Parcelize


@Parcelize
@RealmClass
open class Currency(
    @PrimaryKey var id: Long = 0,
    var code: String = "",
    var name: String = "",
    var quote: Double = -1.0

) : RealmObject(), Parcelable