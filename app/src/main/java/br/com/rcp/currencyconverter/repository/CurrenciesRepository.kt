package br.com.rcp.currencyconverter.repository

import br.com.rcp.currencyconverter.Result
import br.com.rcp.currencyconverter.database.entities.Currency
import br.com.rcp.currencyconverter.dto.CurrencyLayerDTO
import br.com.rcp.currencyconverter.repository.base.Repository
import retrofit2.Response

class CurrenciesRepository: Repository() {
    suspend fun getCurrencies() : List<Currency> {
        getRemoteCurrencies()
        return getRemoteValues()
    }

    private suspend fun getRemoteCurrencies() : List<Currency> {
        when (val result = handle { service.getCurrencies() } ) {
            is Result.Success   -> return onRemoteSuccess(result.data)
            is Result.Failure   -> return onRemoteFailure()
        }
    }

    private suspend fun getRemoteValues() : List<Currency> {
        return when (val result = handle { service.getValues() } ) {
            is Result.Success   -> onRemoteValuesSuccess(result.data)
            is Result.Failure   -> getLocal()
        }
    }

    private fun persist(data: Map<String, String>): List<Currency> {
        return data.entries.map { Currency(it.key, it.value, 0.0) }.onEach { storage.currencyDAO().save(it) }.ifEmpty { getLocal() }
    }

    private fun update(data: Map<String, Double>): List<Currency> {
        data.entries.onEach { storage.currencyDAO().putValue(it.key.removePrefix("USD"), it.value) }
        return storage.currencyDAO().findAll() ?: listOf()
    }

    private fun onRemoteValuesSuccess(remote: Response<CurrencyLayerDTO>): List<Currency> {
        return if (remote.isSuccessful) {
            update(remote.body()!!.quotes ?: mapOf())
        } else {
            getLocal()
        }
    }

    private fun onRemoteSuccess(remote: Response<CurrencyLayerDTO>): List<Currency> {
        return if (remote.isSuccessful) {
            persist(remote.body()!!.currencies ?: mapOf())
        } else {
            getLocal()
        }
    }

    private fun onRemoteFailure(): List<Currency> {
        return storage.currencyDAO().findAll() ?: listOf()
    }

    private fun getLocal() : List<Currency> {
        return storage.currencyDAO().findAll() ?: listOf()
    }
}