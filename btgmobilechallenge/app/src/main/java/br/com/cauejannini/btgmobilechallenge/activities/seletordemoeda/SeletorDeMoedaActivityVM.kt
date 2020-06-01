package br.com.cauejannini.btgmobilechallenge.activities.seletordemoeda

import android.content.Context
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import br.com.cauejannini.btgmobilechallenge.commons.Currency
import br.com.cauejannini.btgmobilechallenge.commons.integracao.ApiRepository
import br.com.cauejannini.btgmobilechallenge.commons.integracao.ResponseHandler
import br.com.cauejannini.btgmobilechallenge.commons.integracao.domains.SupportedCurrenciesResponse

class SeletorDeMoedaActivityVM: ViewModel(), CurrencyRecyclerViewAdapter.OnCurrencySelectedListener {

    val currencies: MutableLiveData<List<Currency>> = MutableLiveData()

    val loading: MutableLiveData<Boolean> = MutableLiveData()
    val outErrorToUser: MutableLiveData<String> = MutableLiveData()

    val selectedCurrencySymbol: MutableLiveData<String> = MutableLiveData()

    fun getCurrencies(context: Context?) {

        loading.value = true

        ApiRepository(context).get().getCotacoesDisponiveis().enqueue(object: ResponseHandler<SupportedCurrenciesResponse>() {
            override fun onSuccess(response: SupportedCurrenciesResponse) {

                val currencies = response.currencies
                currencies?.let{

                    val currencyList = ArrayList<Currency>()
                    for (entry in currencies.entries) {
                        val currency = Currency(entry.key, entry.value)
                        currencyList.add(currency)
                    }
                    this@SeletorDeMoedaActivityVM.currencies.value = currencyList
                }

                loading.value = false
            }

            override fun onFailure(messageToUser: String) {
                this@SeletorDeMoedaActivityVM.outErrorToUser.value = messageToUser

                loading.value = false
                currencies.value = null
            }
        })
    }

    override fun onCurrencySelected(currencySymbol: String) {
        selectedCurrencySymbol.value = currencySymbol
    }

}