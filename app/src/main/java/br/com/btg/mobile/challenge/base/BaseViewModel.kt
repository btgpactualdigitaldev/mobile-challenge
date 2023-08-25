package br.com.btg.mobile.challenge.base

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import br.com.btg.mobile.challenge.helper.SingleLiveEvent
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

open class BaseViewModel : ViewModel() {

    var loading = SingleLiveEvent<Boolean>()
    var error = SingleLiveEvent<Throwable>()

    protected fun launch(
        enableLoading: Boolean = true,
        errorBlock: ((Throwable) -> Unit?)? = null,
        block: suspend CoroutineScope.() -> Unit
    ) =
        viewModelScope.launch {
            if (enableLoading) loading.postValue(true)
            runCatching {
                block()
            }
                .onSuccess { if (enableLoading) loading.postValue(false) }
                .onFailure { error ->
                    if (enableLoading) loading.postValue(false)
                    if (errorBlock != null) errorBlock.invoke(error)
                    else postErrorValue(error)
                }
        }

    private fun postErrorValue(throwable: Throwable) {
        error.postValue(throwable)
    }
}
