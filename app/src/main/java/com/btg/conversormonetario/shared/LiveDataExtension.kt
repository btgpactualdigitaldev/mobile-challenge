package com.btg.conversormonetario.shared

import android.util.Log
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer

private const val TAG = "LiveDataExtension"

fun <T> LiveData<T>.observeNonNull(lifecycleOwner: LifecycleOwner, function: (T) -> Unit) {
    observe(lifecycleOwner, Observer {
        if (it != null) function.invoke(it)
        else Log.d(TAG, "observeNonNull received a null value, ignoring....")
    })
}