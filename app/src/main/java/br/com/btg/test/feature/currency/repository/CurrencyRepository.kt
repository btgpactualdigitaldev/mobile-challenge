package br.com.btg.test.feature.currency.repository

import br.com.btg.test.feature.currency.api.ConvertAPI
import br.com.btg.test.feature.currency.model.ResponseRates
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow


interface CurrencyRepository {
    fun convert(currencies: String): Flow<ResponseRates>
    fun currenciesList(): Flow<Map<String, String>?>
}

class ConvertRepositoryImpl(private val convertAPI: ConvertAPI) :
    CurrencyRepository {
    override fun convert(currencies: String): Flow<ResponseRates> = flow {
        emit(convertAPI.liveRates(currencies))
    }

    override fun currenciesList(): Flow<Map<String, String>?> = flow {
        emit(convertAPI.currenciesList().currencies)
    }
}