package br.com.gft.main.service.model

import com.google.gson.annotations.SerializedName

data class ConvertResponse(
    @SerializedName("msg") val msg:String,
    @SerializedName("number") val number:Int
)
{
    operator fun inc():ConvertResponse{
        val response = ConvertResponse("message:${this.msg}",1)
        return response
    }
}