package br.com.cabral.pedro.conversaodemoeda.service

import android.util.Log
import br.com.cabral.pedro.conversaodemoeda.enum.EnderecoAPI
import br.com.cabral.pedro.conversaodemoeda.model.data.TipoMoedaContract
import br.com.cabral.pedro.conversaodemoeda.model.data.ValorMoedaContract
import br.com.cabral.pedro.conversaodemoeda.model.dto.MoedaTipo
import br.com.cabral.pedro.conversaodemoeda.model.dto.MoedaValor
import br.com.cabral.pedro.conversaodemoeda.retrofit.EndpointList
import br.com.cabral.pedro.conversaodemoeda.retrofit.EndpointLive
import br.com.cabral.pedro.conversaodemoeda.retrofit.RetrofitInstance
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CurrencyLayerService : TipoMoedaContract.CurrencyLayerList, ValorMoedaContract.CurrencyLayerLive {

    override fun getServiceLive(onRetornoValorMoeda: ValorMoedaContract.CurrencyLayerLive.OnRetornoValorMoeda) {
        val callback = RetrofitInstance.getRetrofitInstance()
            .create(EndpointLive::class.java).getLive(EnderecoAPI.CHAVE_ACESSO.valor)

        callback.enqueue(object : Callback<MoedaValor> {
            override fun onResponse(call: Call<MoedaValor>, response: Response<MoedaValor>) {
                Log.v("Success - ", response.body().toString())
                onRetornoValorMoeda.onSuccess(response.body()?.quotes)
            }

            override fun onFailure(call: Call<MoedaValor>, t: Throwable) {
                Log.e("Error - ", t.message.toString())
                onRetornoValorMoeda.onError(t)
            }
        })
    }

    override fun getServiceList(onRetornoTipoMoeda: TipoMoedaContract.CurrencyLayerList.OnRetornoTipoMoeda) {
        val callback = RetrofitInstance.getRetrofitInstance()
            .create(EndpointList::class.java).getList(EnderecoAPI.CHAVE_ACESSO.valor)

        callback.enqueue(object : Callback<MoedaTipo> {
            override fun onResponse(call: Call<MoedaTipo>, response: Response<MoedaTipo>) {
                Log.v("Success - ", response.body().toString())
                onRetornoTipoMoeda.onSuccess(response.body()?.currencies)
            }

            override fun onFailure(call: Call<MoedaTipo>, t: Throwable) {
                Log.e("Error - ", t.message.toString())
                onRetornoTipoMoeda.onError(t)
            }
        })
    }

}