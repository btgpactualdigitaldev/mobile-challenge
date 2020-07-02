package com.test.btg.viewmodel

import android.view.View
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.test.btg.repository.CurrencyRemoteRepository
import com.test.btg.usecase.CurrencyUseCase
import com.test.core.model.Lives
import io.reactivex.disposables.Disposable

class CurrencyViewModel(
    private val useCaseRemote: CurrencyUseCase = CurrencyUseCase(
        CurrencyRemoteRepository()
    )
) : ViewModel() {

    val answers by lazy { MutableLiveData<CurrencyAnswer>() }
    val loadingStatus by lazy { MutableLiveData<CurrencyAnswer.LoadingStatus>() }
    private lateinit var disposable: Disposable

    fun interact(action: CurrencyInteracts) {
        when (action) {
            CurrencyInteracts.CreatedActivity -> createdActivity()
        }
    }

    private fun createdActivity(
        successCallbackLives: (it: Lives?) -> Unit = createSuccessCallbackLives(),
        failureCallbackLives: (it: Throwable) -> Unit = createFailureCallbackLives()
    ) {
        loadingStatus.postValue(CurrencyAnswer.LoadingStatus(View.VISIBLE))

        disposable = useCaseRemote.requestLive(successCallbackLives, failureCallbackLives)
    }

    fun createFailureCallbackLives() = { it: Throwable ->
        loadingStatus.postValue(CurrencyAnswer.LoadingStatus(View.GONE))
        answers.postValue(CurrencyAnswer.Error(it.message.orEmpty()))
    }

    fun createSuccessCallbackLives(): (it: Lives?) -> Unit = {
        loadingStatus.postValue(CurrencyAnswer.LoadingStatus(View.GONE))

        it?.let {
            answers.postValue(CurrencyAnswer.CurrencyLives(it))
        }
    }

    override fun onCleared() {
        if(::disposable.isInitialized && !disposable.isDisposed) {
            disposable.dispose()
        }

        super.onCleared()
    }

}


sealed class CurrencyInteracts {
    object CreatedActivity : CurrencyInteracts()
}

sealed class CurrencyAnswer {

    data class Error(val message: String) : CurrencyAnswer()
    data class CurrencyLives(val lives: Lives) : CurrencyAnswer()
    data class LoadingStatus(val visibility: Int) : CurrencyAnswer()
}