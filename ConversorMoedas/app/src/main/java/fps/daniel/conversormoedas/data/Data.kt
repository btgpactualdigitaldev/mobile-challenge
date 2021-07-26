package fps.daniel.conversormoedas.data

import fps.daniel.conversormoedas.enity.CurrencyLayer

interface Data {

    fun onCreate()
    fun getCurrencies(): List<CurrencyLayer>
    fun postCurrencies(currencies: List<CurrencyLayer>)
    fun onDestroy()

}