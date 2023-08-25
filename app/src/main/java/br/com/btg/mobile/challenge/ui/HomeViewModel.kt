package br.com.btg.mobile.challenge.ui

import androidx.lifecycle.LiveData
import br.com.btg.mobile.challenge.base.BaseViewModel
import br.com.btg.mobile.challenge.data.model.Price
import br.com.btg.mobile.challenge.data.model.Rate
import br.com.btg.mobile.challenge.data.repository.PriceRepository
import br.com.btg.mobile.challenge.data.repository.RateRepository
import br.com.btg.mobile.challenge.helper.SingleLiveEvent

class HomeViewModel(
    private val rateRepository: RateRepository,
    private val priceRepository: PriceRepository
) : BaseViewModel() {

    private val _dataRatesSuccess = SingleLiveEvent<List<Rate>>()
    val dataRatesSuccess: LiveData<List<Rate>> = _dataRatesSuccess

    private val _dataPricesSuccess = SingleLiveEvent<List<Price>>()
    val dataPricesSuccess: LiveData<List<Price>> = _dataPricesSuccess

    var listRates: List<Rate> = emptyList()
    var listPrices: List<Price> = emptyList()

    fun getPrices() {
        launch {
            priceRepository.getPrices()?.let {
                listPrices = it
                _dataPricesSuccess.postValue(it)
            }
        }
    }

    fun getRates() {
        launch {
            rateRepository.getRates()?.let {
                listRates = it
                _dataRatesSuccess.postValue(it)
            }
        }
    }

    fun convertValue(value: Double, tx: Double) = (value / tx).toString()
}
