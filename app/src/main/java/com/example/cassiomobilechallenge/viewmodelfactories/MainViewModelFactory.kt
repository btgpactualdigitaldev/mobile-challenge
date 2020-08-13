package com.example.cassiomobilechallenge.viewmodelfactories

import android.app.Application
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.example.cassiomobilechallenge.repositories.CurrencyRepository
import com.example.cassiomobilechallenge.viewmodels.MainViewModel

class MainViewModelFactory constructor(private val repository: CurrencyRepository,
                                         private val application: Application
): ViewModelProvider.Factory {

    override fun <T : ViewModel?> create(modelClass: Class<T>): T =
        with(modelClass) {
            when {
                isAssignableFrom(MainViewModel::class.java) ->
                    MainViewModel(repository, application)
                else ->
                    throw IllegalArgumentException("Erro: ViewModel inexistente.")
            }
        } as T
}