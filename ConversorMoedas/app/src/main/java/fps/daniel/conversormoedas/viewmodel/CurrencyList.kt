package fps.daniel.conversormoedas.viewmodel

import fps.daniel.conversormoedas.enity.CurrencyLayer

interface CurrencyList {
    fun setRecyclerViewArray(array: ArrayList<CurrencyLayer>)
    fun setOrderButtonText(text: String)
    fun finishWithResultingCurrency(currency: CurrencyLayer)
}