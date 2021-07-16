package br.com.conversordemoedas.model

import br.com.conversordemoedas.utils.Network
import retrofit2.Callback

class ListManager(private val network: Network) {

    fun getCurrencyList(callback: Callback<List>) {
        val currencyLayer = network.currencyLayerService()
        val call =  currencyLayer.getCurrencyList()
        call.enqueue(callback)
    }

    fun createCurrencyList(list: List): kotlin.collections.List<Currency> {
        val listCurrency = mutableListOf<Currency>()
        for (item in list.currencies){
            listCurrency.add(Currency(item.key, item.value))
        }
        return listCurrency
    }

}