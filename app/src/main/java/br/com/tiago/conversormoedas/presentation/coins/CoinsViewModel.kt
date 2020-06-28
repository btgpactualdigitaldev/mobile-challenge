package br.com.tiago.conversormoedas.presentation.coins

import android.content.Context
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import br.com.tiago.conversormoedas.R
import br.com.tiago.conversormoedas.data.CoinsRepository
import br.com.tiago.conversormoedas.data.CoinsResult
import br.com.tiago.conversormoedas.data.model.Coin
import java.lang.IllegalArgumentException

class CoinsViewModel(private val dataSource: CoinsRepository): ViewModel() {

    val coinsLiveData: MutableLiveData<List<Coin>> = MutableLiveData()
    val viewFlipperLiveData: MutableLiveData<Pair<Int, Int?>> = MutableLiveData()

    fun getCoins() {
        dataSource.getCoins { result: CoinsResult ->
            when(result) {
                is CoinsResult.Success -> {
                    coinsLiveData.value = result.coins.sortedBy { it.initials }
                    viewFlipperLiveData.value = Pair(VIEW_FLIPPER_COINS, null)
                }
                is CoinsResult.ApiError -> {
                    if (result.statusCode == 401) {
                        viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.coins_error_401)
                    } else {
                        viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.coins_error_400_generic)
                    }
                }
                is CoinsResult.ServerError -> {
                    viewFlipperLiveData.value = Pair(VIEW_FLIPPER_ERROR, R.string.coins_error_500_generic)
                }
            }
        }
    }

    fun getCoinsDB(type: String?){
        dataSource.getCoinsDB { result: CoinsResult ->
            when(result) {
                is CoinsResult.Success -> {

                    if (type == null || type == "init"){
                        coinsLiveData.value = result.coins.sortedBy { it.initials }
                    } else {
                        coinsLiveData.value = result.coins.sortedBy { it.name }
                    }

                    //coinsLiveData.value = result.coins
                    viewFlipperLiveData.value = Pair(VIEW_FLIPPER_COINS, null)
                }
                is CoinsResult.DBError -> {
                    getCoins()
                }
            }
        }
    }

    class ViewModelFactory(private val dataSource: CoinsRepository) : ViewModelProvider.Factory {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            if (modelClass.isAssignableFrom(CoinsViewModel::class.java)) {
                return CoinsViewModel(dataSource) as T
            }
            throw IllegalArgumentException("Unknown ViewModel Class")
        }

    }

    companion object{
        private const val VIEW_FLIPPER_COINS = 1
        private const val VIEW_FLIPPER_ERROR = 2
    }
}