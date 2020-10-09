package br.com.cabral.pedro.conversaodemoeda.retrofit

import br.com.cabral.pedro.conversaodemoeda.model.dto.MoedaTipo
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface EndpointList {
    @GET("list?")
    fun getList(@Query("access_key") chaveAcesso: String) : Call<MoedaTipo>
}