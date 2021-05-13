package com.btg.convertercurrency.data_network.server.endpoints.response

import com.google.gson.annotations.SerializedName

data class CurrencyObjectResponse (

	@SerializedName("success") val success : Boolean = false,
	@SerializedName("terms") val terms : String = "",
	@SerializedName("privacy") val privacy : String = "" ,
	@SerializedName("currencies") val currencies : MutableList<CurrenciesResponse> = mutableListOf(),
	@SerializedName("error") val errorResponse : ErrorResponse = ErrorResponse()
)