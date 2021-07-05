package br.com.android.challengeandroid.list.viewmodel.states

import br.com.android.challengeandroid.model.CoinList

sealed class ListEvent {
    object LoadingVisible : ListEvent()
    object LoadingGone : ListEvent()
    data class Error(val message: String) : ListEvent()
    data class SuccessList(val list: List<CoinList>) : ListEvent()
}
