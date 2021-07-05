package br.com.android.challengeandroid.home.viewmodel.states

sealed class HomeInteractor {
    data class ToConvertCoin(val source: String, val destiny: String, val value: Double) :
        HomeInteractor()
}
