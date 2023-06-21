package com.btg.convertercurrency.data_network.server.endpoints.response

import com.google.gson.annotations.SerializedName

data class QuotesObjectResponse (

	@SerializedName("success") val success : Boolean,
	@SerializedName("terms") val terms : String,
	@SerializedName("privacy") val privacy : String,
	@SerializedName("timestamp") val timeStamp : String,
	@SerializedName("source") val source : String,
	@SerializedName("error") val errorResponse : ErrorResponse = ErrorResponse(),
	@SerializedName("quotes") val quotes : MutableList<QuotesResponse>
)