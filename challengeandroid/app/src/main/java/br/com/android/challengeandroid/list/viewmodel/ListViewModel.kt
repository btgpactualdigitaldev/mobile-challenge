package br.com.android.challengeandroid.list.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.android.challengeandroid.list.view.ListActivity.Companion.RC_LIST_SOURCE
import br.com.android.challengeandroid.list.viewmodel.states.ListEvent
import br.com.android.challengeandroid.list.viewmodel.states.ListInteractor
import br.com.android.challengeandroid.usecase.CoinUseCase
import kotlinx.coroutines.launch

class ListViewModel(private val useCase: CoinUseCase) : ViewModel() {

    private val event: MutableLiveData<ListEvent> = MutableLiveData()
    val viewEvent: LiveData<ListEvent> = event

    fun interactor(interactor: ListInteractor) {
        when (interactor) {
            is ListInteractor.CurrenciesAccepted -> currenciesAccepted(interactor.typeList)
        }
    }

    fun getCoinList(coinSource: String) {
        viewModelScope.launch {
            event.value = ListEvent.LoadingVisible
            try {
                val result = useCase.getCoinList(coinSource)
                event.value = ListEvent.SuccessList(result)
                event.value = ListEvent.LoadingGone
            } catch (exception: Exception) {
                event.value = ListEvent.Error(exception.message.toString())
            }
        }
    }

    fun currenciesAccepted(typeList: Int): List<String> =
        if (typeList == RC_LIST_SOURCE) {
            useCase.currenciesAccepted()
        } else {
            arrayListOf()
        }
}
