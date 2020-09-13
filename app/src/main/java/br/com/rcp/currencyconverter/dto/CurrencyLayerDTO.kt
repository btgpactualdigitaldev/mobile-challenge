package br.com.rcp.currencyconverter.dto

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

data class CurrencyLayerDTO(
    @Expose  @SerializedName("success")     val success     : Boolean,
    @Expose  @SerializedName("terms")       val terms       : String,
    @Expose  @SerializedName("privacy")     val privacy     : String,
    @Expose  @SerializedName("timestamp")   val timestamp   : Long?,
    @Expose  @SerializedName("source")      val source      : String?,
    @Expose  @SerializedName("quotes")      val quotes      : Map<String, Double>?,
    @Expose  @SerializedName("currencies")  val currencies  : Map<String, String>?
)