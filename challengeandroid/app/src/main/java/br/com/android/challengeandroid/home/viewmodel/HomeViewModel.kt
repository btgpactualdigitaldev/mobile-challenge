package br.com.android.challengeandroid.home.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.android.challengeandroid.home.viewmodel.states.HomeEvent
import br.com.android.challengeandroid.home.viewmodel.states.HomeInteractor
import br.com.android.challengeandroid.usecase.CoinUseCase
import kotlinx.coroutines.launch

class HomeViewModel(private val useCase: CoinUseCase) : ViewModel() {

    private val event: MutableLiveData<HomeEvent> = MutableLiveData()
    val viewEvent: LiveData<HomeEvent> = event

    fun interactor(interactor: HomeInteractor) {
        when (interactor) {
            is HomeInteractor.ToConvertCoin -> getPriceByCoin(interactor.source, interactor.destiny, interactor.value)
        }
    }

    private fun getPriceByCoin(source: String, destiny: String, value: Double) {
        viewModelScope.launch {
            event.value = HomeEvent.Loading
            try {
                val result = useCase.getPriceByCoin(source, destiny)
                val calc = useCase.calculatesQuotation(value, result)
                event.value = HomeEvent.SuccessPrice(calc)
            } catch (exception: Exception) {
                event.value = HomeEvent.Error(exception.message.toString())
            }
        }
    }
}
