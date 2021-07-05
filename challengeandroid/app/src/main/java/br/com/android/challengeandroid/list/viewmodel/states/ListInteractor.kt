package br.com.android.challengeandroid.list.viewmodel.states

sealed class ListInteractor {
    data class CurrenciesAccepted(val typeList: Int) : ListInteractor()
}
