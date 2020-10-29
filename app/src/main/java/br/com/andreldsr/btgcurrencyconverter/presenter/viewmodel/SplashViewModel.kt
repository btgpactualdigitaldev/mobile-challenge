package br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import br.com.andreldsr.btgcurrencyconverter.data.dao.CurrencyDAO
import br.com.andreldsr.btgcurrencyconverter.data.datasources.CurrencyDatasourceImpl
import br.com.andreldsr.btgcurrencyconverter.data.db.AppDatabase
import br.com.andreldsr.btgcurrencyconverter.data.model.CurrencyEntity
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency
import br.com.andreldsr.btgcurrencyconverter.domain.repositories.CurrencyRepository
import br.com.andreldsr.btgcurrencyconverter.infra.datasources.CurrencyDatasource
import br.com.andreldsr.btgcurrencyconverter.infra.repositories.CurrencyRepositoryImpl
import br.com.andreldsr.btgcurrencyconverter.util.ConnectionUtil
import br.com.andreldsr.btgcurrencyconverter.util.ConnectionUtil.context
import kotlinx.coroutines.launch
import java.util.*

class SplashViewModel(
    private val repository: CurrencyRepository,
    private val currencyDatasource: CurrencyDatasource
) : ViewModel() {

    sealed class SplashState {
        object loadingSplashState : SplashState()
        object internetErrorFirstAccessSplashState : SplashState()
        object loadFromDatabaseSplashState : SplashState()
        object loadFromAPISplashState : SplashState()
    }

    val splashState = MutableLiveData<SplashState>(SplashState.loadingSplashState)
    private var currencyList = mutableListOf<Currency>()
    private var quoteList = mapOf<String, String>()
    fun initCurrencyData() {
        viewModelScope.launch {
            currencyList = repository.getCurrency().toMutableList()
            if (currencyList.size == 0) {
                splashState.value = SplashState.internetErrorFirstAccessSplashState
                return@launch
            }




            if (ConnectionUtil.isNetworkConnected()) {
                quoteList = repository.getQuoteList()
                currencyDatasource.deleteAll()
                currencyList.map { currency ->
                    val currencyEntity = CurrencyEntity(
                        id = null,
                        name = currency.name,
                        initials = currency.initials,
                        lastTimeUpdated = Calendar.getInstance().timeInMillis,
                        quote = (quoteList[baseCurrencyName+currency.initials] ?: error("")).toFloat()
                    )
                    currencyDatasource.save(currencyEntity)
                }
                splashState.value = SplashState.loadFromAPISplashState
            } else {
                splashState.value = SplashState.loadFromDatabaseSplashState
            }

        }
    }

    companion object {
        const val baseCurrencyName = "USD"
    }

    class ViewModelFactory() : ViewModelProvider.Factory {
        private val repository = CurrencyRepositoryImpl.build()
        private val datasource =
            CurrencyDatasourceImpl(AppDatabase.getInstance(context).currencyDao)

        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(SplashViewModel::class.java)) return SplashViewModel(
                repository,
                datasource
            ) as T
            throw IllegalArgumentException("Unknown ViewModel class")
        }
    }
}