package br.com.cabral.pedro.conversaodemoeda.model.dto

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName
import java.math.BigDecimal

class MoedaValor {

    @SerializedName("quotes")
    @Expose
    val quotes: HashMap<String, BigDecimal>? = null

}