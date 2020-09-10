package com.example.conversordemoeda.viewmodel

import androidx.annotation.VisibleForTesting
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.conversordemoeda.model.entidades.Cotacao
import com.example.conversordemoeda.model.repositorio.MoedaRepository
import com.example.conversordemoeda.model.repositorio.STATUS
import com.example.conversordemoeda.model.repositorio.modelResponseCustom.CotacaoResponseCustom
import com.example.conversordemoeda.model.retrofit.CallbackResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainViewModel(private val moedaRepository: MoedaRepository) : ViewModel(), LifecycleObserver {

    val cotacaoData: MutableLiveData<CotacaoResponseCustom> =
        MutableLiveData(CotacaoResponseCustom(status = STATUS.OPEN_LOADING))

    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    var cambioDeOrigem: String = "USD"
    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    var cambioDeDestino: String = "USD"
    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    var cambioPadrao: String = "USD"
    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    var valorInformado: Float = 0F

    private var quotes: HashMap<String, Float> = hashMapOf()

    init {
        getListaDeCotacoes()
    }

    private fun getListaDeCotacoes() {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                moedaRepository.getContacao(object : CallbackResponse<Cotacao> {
                    override fun success(response: Cotacao) {
                        cambioDeOrigem = response.source
                        cambioDeDestino = response.source
                        cambioPadrao = response.source
                        quotes = response.quotes
                        converterMoeda()
                    }

                    override fun failure(mensagem: String) {
                        cotacaoData.postValue(cotacaoData.value?.apply {
                            errorMessage = mensagem
                            status = STATUS.ERROR
                        })
                    }
                })
            }
        }
    }

    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    fun definirCambioDeOrigem(cambio: String) {
        cambioDeOrigem = cambio
    }
    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    fun definirCambioDeDestino(cambio: String) {
        cambioDeDestino = cambio
    }
    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    fun setValor(valor: Float){
        valorInformado = valor
    }

    fun converterMoeda() {
        if (cambioPadrao == cambioDeOrigem) {
            quotes["$cambioDeOrigem$cambioDeDestino"]?.let { conversaoDeValor(cotacao = it, valor = valorInformado) }
        } else {
            quotes["$cambioPadrao$cambioDeOrigem"]?.let { preConversaoDeValor(cotacao = it, valor = valorInformado) }
        }
    }

    private fun preConversaoDeValor(cotacao: Float, valor: Float) {
        quotes["$cambioPadrao$cambioDeDestino"]?.let { conversaoDeValor(cotacao = it, valor = dividirValor(cotacao, valor)) }
    }

    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    fun dividirValor(cotacao: Float, valor: Float) = valor / cotacao

    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    fun multiplicarValor(cotacao: Float, valor: Float) = valor * cotacao

    fun conversaoDeValor(cotacao: Float, valor: Float){
        cotacaoData.postValue(cotacaoData.value?.apply {
            valorConvertido = multiplicarValor(cotacao, valor)
            status = STATUS.SUCCESS
        })
    }
}