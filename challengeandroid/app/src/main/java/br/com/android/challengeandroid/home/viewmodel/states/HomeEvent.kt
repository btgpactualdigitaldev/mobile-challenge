package br.com.android.challengeandroid.home.viewmodel.states

sealed class HomeEvent {
    object Loading : HomeEvent()
    data class Error(val message: String) : HomeEvent()
    data class SuccessPrice(val price: Double) : HomeEvent()
}
