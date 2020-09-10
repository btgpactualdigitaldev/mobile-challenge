package com.example.conversordemoeda.viewmodel

import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.conversordemoeda.model.entidades.Cambio
import com.example.conversordemoeda.model.repositorio.MoedaRepository
import com.example.conversordemoeda.model.repositorio.STATUS
import com.example.conversordemoeda.model.repositorio.modelResponseCustom.CambioResponseCustom
import com.example.conversordemoeda.model.retrofit.CallbackResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class ListaDeMoedasViewModel(private val moedaRepository: MoedaRepository) : ViewModel(),
    LifecycleObserver {

    val cambioData: MutableLiveData<CambioResponseCustom> =
        MutableLiveData(CambioResponseCustom(status = STATUS.OPEN_LOADING))

    init {
        getListaDeMoedas()
    }

    private fun getListaDeMoedas() {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                moedaRepository.getCambio(object : CallbackResponse<Cambio> {
                    override fun success(response: Cambio) {
                        cambioData.postValue(cambioData.value?.apply {
                            cambioMap = response.currencies
                            status = STATUS.SUCCESS
                        })

                    }

                    override fun failure(mensagem: String) {
                        cambioData.postValue(cambioData.value?.apply {
                            errorMessage = mensagem
                            status = STATUS.ERROR
                        })
                    }
                })
            }
        }
    }
}