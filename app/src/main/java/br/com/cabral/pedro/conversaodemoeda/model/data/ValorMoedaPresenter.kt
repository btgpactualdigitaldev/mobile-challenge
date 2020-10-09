package br.com.cabral.pedro.conversaodemoeda.model.data

import java.math.BigDecimal

class ValorMoedaPresenter(private var view: ValorMoedaContract.View? = null,
                          private var currencyLayerLive: ValorMoedaContract.CurrencyLayerLive? = null) :
    ValorMoedaContract.Presenter, ValorMoedaContract.CurrencyLayerLive.OnRetornoValorMoeda {

    override fun chamarMoedaValor() {
        currencyLayerLive?.getServiceLive(this)
    }

    override fun onSuccess(moedaValor: HashMap<String, BigDecimal>?) {
        view?.callBackMoedaValor(moedaValor)
    }

    override fun onError(throwable: Throwable) {
        view?.callBackErro(throwable.toString())
    }

}