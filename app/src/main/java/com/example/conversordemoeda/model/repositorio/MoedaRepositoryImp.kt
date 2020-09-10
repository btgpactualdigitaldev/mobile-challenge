package com.example.conversordemoeda.model.repositorio

import com.example.conversordemoeda.model.entidades.Cambio
import com.example.conversordemoeda.model.entidades.Cotacao
import com.example.conversordemoeda.model.retrofit.CallbackResponse
import com.example.conversordemoeda.model.retrofit.RetrofitConfig
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class MoedaRepositoryImp(val retrofitConfig: RetrofitConfig) : MoedaRepository {

    override fun getCambio(callbackResponse: CallbackResponse<Cambio>) {
        val call = retrofitConfig.moedaService().getCambio()
        call.enqueue(object : Callback<Cambio> {
            override fun onResponse(call: Call<Cambio>, response: Response<Cambio>) {
                if (response.isSuccessful) {
                    response.body()?.let {
                        if (it.success)
                            callbackResponse.success(it)
                        else
                            callbackResponse.failure(it.error.info)
                    }
                } else {
                    callbackResponse.failure(response.message())
                }
            }

            override fun onFailure(call: Call<Cambio>, t: Throwable) {
                t.message?.let { callbackResponse.failure(it) }
            }
        })
    }

    override fun getContacao(callbackResponse: CallbackResponse<Cotacao>) {
        val call = retrofitConfig.moedaService().getCotacao()
        call.enqueue(object : Callback<Cotacao> {
            override fun onResponse(call: Call<Cotacao>, response: Response<Cotacao>) {
                if (response.isSuccessful) {
                    response.body()?.let {
                        if (it.success)
                            callbackResponse.success(it)
                        else
                            callbackResponse.failure(it.error.info)
                    }
                } else {
                    callbackResponse.failure(response.message())
                }
            }

            override fun onFailure(call: Call<Cotacao>, t: Throwable) {
                t.message?.let { callbackResponse.failure(it) }
            }
        })
    }
}