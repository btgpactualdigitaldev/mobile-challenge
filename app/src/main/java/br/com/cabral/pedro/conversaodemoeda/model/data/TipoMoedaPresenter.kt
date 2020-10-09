package br.com.cabral.pedro.conversaodemoeda.model.data


class TipoMoedaPresenter(private var view: TipoMoedaContract.View? = null,
                         private var currencyLayerList: TipoMoedaContract.CurrencyLayerList? = null) :
    TipoMoedaContract.Presenter, TipoMoedaContract.CurrencyLayerList.OnRetornoTipoMoeda {

    override fun chamarMoedaTipo() {
        currencyLayerList?.getServiceList(this)
    }

    override fun onSuccess(moedaTipo: HashMap<String, String>?) {
        view?.callBackMoedaTipo(moedaTipo)
    }

    override fun onError(throwable: Throwable) {
        view?.callBackErro(throwable.toString())
    }

}