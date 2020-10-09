package br.com.cabral.pedro.conversaodemoeda.retrofit

import br.com.cabral.pedro.conversaodemoeda.model.dto.MoedaValor
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface EndpointLive {
    @GET("live?")
    fun getLive(@Query("access_key") chaveAcesso: String) : Call<MoedaValor>
}