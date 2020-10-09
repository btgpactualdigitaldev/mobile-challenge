package br.com.cabral.pedro.conversaodemoeda.model.data

import java.math.BigDecimal

interface ValorMoedaContract {

    interface View  {
        fun callBackMoedaValor(moedaValor: HashMap<String, BigDecimal>?)
        fun callBackErro(msg: String)
    }

    interface Presenter {
        fun chamarMoedaValor()
    }

    interface CurrencyLayerLive {
        interface OnRetornoValorMoeda {
            fun onSuccess(moedaValor: HashMap<String, BigDecimal>?)
            fun onError(throwable: Throwable)
        }
        fun getServiceLive(onRetornoValorMoeda: OnRetornoValorMoeda)
    }

}