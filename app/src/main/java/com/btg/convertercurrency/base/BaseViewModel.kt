package com.btg.convertercurrency.base

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.MutableLiveData
import com.btg.convertercurrency.features.util.Event
import com.btg.convertercurrency.features.util.default


open class BaseViewModel<T>(application: Application) : AndroidViewModel(application),
    LifecycleObserver {

    val loadingLiveData = MutableLiveData<Event<Boolean>>().default(Event(false))
    val errorLiveData = MutableLiveData<Event<Int>>().default(Event(0))
    val success = MutableLiveData<Event<T>>()
}