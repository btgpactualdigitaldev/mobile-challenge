package br.com.android.challengeandroid.home.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import br.com.android.challengeandroid.usecase.CoinUseCase

class HomeViewModelFactory(private val useCase: CoinUseCase) : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return modelClass.getConstructor(CoinUseCase::class.java).newInstance(useCase)
    }
}