package br.com.albertomagalhaes.btgcurrencies.repository

import br.com.albertomagalhaes.btgcurrencies.dto.CurrencyDTO
import com.btgpactual.currencyconverter.data.framework.retrofit.ClientAPI

interface CurrencyRepository {
    suspend fun getCurrencyList(onlySelected: Boolean = false) : List<CurrencyDTO>?
    suspend fun synchronizeCurrencyList():ClientAPI.ResponseType
    suspend fun updateCurrencyListSelected(currencyList: List<CurrencyDTO>, onSuccess: () -> Unit)
    suspend fun setDefaultCurrencyListSeleted(onSuccess: () -> Unit)
    suspend fun hasCurrencyList(): Boolean
}