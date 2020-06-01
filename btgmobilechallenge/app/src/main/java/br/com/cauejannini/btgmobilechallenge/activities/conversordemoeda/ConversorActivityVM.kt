package br.com.cauejannini.btgmobilechallenge.activities.conversordemoeda

import android.content.Context
import androidx.databinding.ObservableField
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import br.com.cauejannini.btgmobilechallenge.commons.Utils
import br.com.cauejannini.btgmobilechallenge.commons.integracao.ApiRepository
import br.com.cauejannini.btgmobilechallenge.commons.integracao.ResponseHandler
import br.com.cauejannini.btgmobilechallenge.commons.integracao.domains.RatesResponse

class ConversorActivityVM: ViewModel() {

    var moedaEntrada: MutableLiveData<String> = MutableLiveData()
    var moedaSaida: MutableLiveData<String> = MutableLiveData()

    var valorSaidaFormatado: ObservableField<String> = ObservableField()

    val loadingConversao: MutableLiveData<Boolean> = MutableLiveData()

    val outErrorToUser: MutableLiveData<String> = MutableLiveData()

    fun init() {
        loadingConversao.value = false
    }

    fun converter(context: Context?, valorEntrada: Double) {

        val moedaEntrada = moedaEntrada.value
        val moedaSaida = moedaSaida.value

        if (moedaEntrada == null || moedaEntrada.isEmpty()) {
            outErrorToUser.value = "Escolha uma moeda de entrada"
            return
        }

        if (moedaSaida == null || moedaSaida.isEmpty()) {
            outErrorToUser.value = "Escolha uma moeda de saída"
            return
        }

        loadingConversao.value = true

        ApiRepository(context).get().getTaxasDeConversao("USD", "$moedaEntrada,$moedaSaida").enqueue(object: ResponseHandler<RatesResponse>() {
            override fun onFailure(messageToUser: String) {

                this@ConversorActivityVM.outErrorToUser.value = messageToUser
                loadingConversao.value = false
            }

            override fun onSuccess(response: RatesResponse) {

                response.quotes?.let {

                    val taxaConversaoDolarEntrada = it.get("USD$moedaEntrada")
                    val taxaConversaoDolarSaida = it.get("USD$moedaSaida")

                    if (taxaConversaoDolarEntrada == null) {
                        this@ConversorActivityVM.outErrorToUser.value = "Moeda de entrada não encontrada";
                        loadingConversao.value = false
                        return
                    }

                    if (taxaConversaoDolarSaida == null) {
                        this@ConversorActivityVM.outErrorToUser.value = "Moeda de saída não encontrada";
                        loadingConversao.value = false
                        return
                    }

                    val valorSaida = (valorEntrada / taxaConversaoDolarEntrada) * taxaConversaoDolarSaida

                    valorSaidaFormatado.set(Utils.doubleParaValorMonetario(valorSaida))

                    loadingConversao.value = false
                }
            }
        })

    }
}