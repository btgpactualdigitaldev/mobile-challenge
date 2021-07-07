package leandro.com.leandroteste.viewmodel

import android.app.Application
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import leandro.com.leandroteste.datasource.ICurrencyDataSource

class CurrencyListViewModelFactory constructor(private val repository: ICurrencyDataSource,
                                               private val application: Application
):
    ViewModelProvider.Factory{
    override fun <T : ViewModel?> create(modelClass: Class<T>): T =
        with(modelClass){
            when{
                isAssignableFrom(CurrencyListViewModel::class.java) ->
                    CurrencyListViewModel(
                        repository,
                        application
                    )
                else ->
                    throw IllegalArgumentException("Classe desconhecida.")
            }
        } as T
}