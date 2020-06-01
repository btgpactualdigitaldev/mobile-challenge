package br.com.cauejannini.btgmobilechallenge.commons.integracao

import br.com.cauejannini.btgmobilechallenge.commons.integracao.domains.RatesResponse
import br.com.cauejannini.btgmobilechallenge.commons.integracao.domains.SupportedCurrenciesResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface Api {

    @GET("list")
    fun getCotacoesDisponiveis(): Call<SupportedCurrenciesResponse>

    @GET("live")
    fun getTaxasDeConversao(@Query("source") source: String, @Query("currencies") currencies: String): Call<RatesResponse>
}