package com.example.desafiobtg.model.listofcurrencymodel

import com.google.gson.annotations.SerializedName

data class CurrencyListModel(
        @SerializedName("sucess")
        val success: Boolean?,
        @SerializedName("currencies")
        val currencyList: Map<String, String>?
)