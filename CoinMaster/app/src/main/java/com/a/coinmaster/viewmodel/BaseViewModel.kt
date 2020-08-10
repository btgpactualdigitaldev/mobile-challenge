package com.a.coinmaster.viewmodel

import androidx.lifecycle.ViewModel
import io.reactivex.disposables.CompositeDisposable

open class BaseViewModel : ViewModel() {
    val disposables: CompositeDisposable = CompositeDisposable()

    override fun onCleared() {
        disposables.dispose()
    }
}
