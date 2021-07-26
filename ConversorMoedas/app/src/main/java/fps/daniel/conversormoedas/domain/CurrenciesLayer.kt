package fps.daniel.conversormoedas.domain

import fps.daniel.conversormoedas.data.Data
import fps.daniel.conversormoedas.enity.CurrencyLayer
import fps.daniel.conversormoedas.viewmodel.CurrencyList

class CurrenciesLayer (val view : CurrencyList,
                       val database: Data) {

    val ORDENAR_CODIGO = "Ordenar por Código"
    val ORDENAR_NOME = "Ordenar por Nome"

    private var currentOrder = ORDENAR_CODIGO
    private var currentQuery = ""

    fun onCreate() {
        database.onCreate()
        clearSearch()
    }

    fun search(query: String) {
        currentQuery = query
        if(currentOrder == ORDENAR_CODIGO) {
            orderByTicker()
        } else {
            orderByName()
        }
    }

    fun clearSearch() {
        currentQuery = ""
        view.setRecyclerViewArray(ArrayList(database.getCurrencies()))
    }

    fun orderByTicker() {
        currentOrder = ORDENAR_CODIGO
        view.setRecyclerViewArray(ArrayList(database.getCurrencies().sortedBy { it.symbol }.filter { it.matchesQuery(currentQuery) }))
        view.setOrderButtonText(ORDENAR_CODIGO)
    }

    fun orderByName() {
        currentOrder = ORDENAR_NOME
        view.setRecyclerViewArray(ArrayList(database.getCurrencies().sortedBy { it.name }.filter { it.matchesQuery(currentQuery) }))
        view.setOrderButtonText(ORDENAR_NOME)
    }

    fun reorderList() {
        if (currentOrder == ORDENAR_CODIGO) orderByName() else orderByTicker()
    }


    fun onCurrencySelected(selectedCurrency: CurrencyLayer) {
        view.finishWithResultingCurrency(selectedCurrency)
    }

    fun onDestroy() {
        database.onDestroy()
    }
}