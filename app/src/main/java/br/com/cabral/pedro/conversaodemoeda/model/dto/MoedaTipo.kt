package br.com.cabral.pedro.conversaodemoeda.model.dto

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

class MoedaTipo {

    @SerializedName("currencies")
    @Expose
    val currencies: HashMap<String, String>? = null

}