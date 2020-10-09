package br.com.cabral.pedro.conversaodemoeda.model.data

interface TipoMoedaContract {

    interface View  {
        fun callBackMoedaTipo(moedaTipo: HashMap<String, String>?)
        fun callBackErro(msg: String)
    }

    interface Presenter {
        fun chamarMoedaTipo()
    }

    interface CurrencyLayerList {
        interface OnRetornoTipoMoeda {
            fun onSuccess(moedaTipo: HashMap<String, String>?)
            fun onError(throwable: Throwable)
        }
        fun getServiceList(onRetornoTipoMoeda: OnRetornoTipoMoeda)
    }

}