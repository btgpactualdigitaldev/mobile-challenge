package com.alexandreac.mobilechallenge.viewmodel.factory

import android.app.Application
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.alexandreac.mobilechallenge.model.datasource.ICurrencyDataSource
import com.alexandreac.mobilechallenge.viewmodel.CurrencyListViewModel
import java.lang.IllegalArgumentException

class CurrencyListViewModelFactory constructor(private val repository: ICurrencyDataSource,
                                               private val application: Application):
                                                ViewModelProvider.Factory{
    override fun <T : ViewModel?> create(modelClass: Class<T>): T =
        with(modelClass){
            when{
                isAssignableFrom(CurrencyListViewModel::class.java) ->
                    CurrencyListViewModel(repository, application)
                else ->
                    throw IllegalArgumentException("Classe desconhecida.")
            }
        } as T
}