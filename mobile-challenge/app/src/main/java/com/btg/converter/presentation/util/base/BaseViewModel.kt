package com.btg.converter.presentation.util.base

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.btg.converter.presentation.util.dialog.DialogData
import com.btg.converter.presentation.util.error.ErrorHandler
import com.btg.converter.presentation.util.navigation.NavData
import com.btg.converter.presentation.util.placeholder.Placeholder
import com.btg.converter.presentation.util.placeholder.types.Hide
import com.btg.converter.presentation.util.placeholder.types.Loading
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import org.koin.core.KoinComponent
import org.koin.core.inject

abstract class BaseViewModel : ViewModel(), KoinComponent {

    private val errorHandler: ErrorHandler by inject()

    val placeholder: LiveData<Placeholder> get() = _placeholder
    val goTo: LiveData<NavData> get() = _goTo
    val dialog: LiveData<DialogData> get() = _dialog

    private val _placeholder by lazy { MutableLiveData<Placeholder>() }
    private val _goTo by lazy { MutableLiveData<NavData>() }
    private val _dialog by lazy { MutableLiveData<DialogData>() }

    protected fun setPlaceholder(placeholder: Placeholder) {
        _placeholder.postValue(placeholder)
    }

    protected fun setDialog(dialogData: DialogData) {
        _dialog.postValue(dialogData)
    }

    protected fun setDialog(
        throwable: Throwable,
        retryAction: (() -> Unit)? = null
    ) {
        setDialog(errorHandler.getDialogData(throwable, retryAction))
    }

    protected fun goTo(navData: NavData) {
        _goTo.postValue(navData)
    }

    protected fun launchDataLoad(
        shouldLoad: Boolean = true,
        onFailure: (Throwable) -> Unit = ::onFailure,
        block: suspend () -> Unit
    ): Job {
        return viewModelScope.launch {
            try {
                if (shouldLoad) setPlaceholder(Loading())
                block()
            } catch (error: Throwable) {
                onFailure(error)
            } finally {
                setPlaceholder(Hide())
            }
        }
    }

    private fun onFailure(trowable: Throwable) {
        setDialog(trowable)
    }
}