package com.br.cambio.utils

import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer
import org.junit.Assert
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit

fun <T> LiveData<T>.verify(body: ((T?) -> Unit)? = null) {
    val latch = CountDownLatch(1)

    var verify = false

    var observer: Observer<T>? = null

    observer = Observer {
        latch.countDown()
        verify = true
        this.removeObserver(observer!!)
        body?.invoke(this.value)
    }

    this.observeForever(observer)

    latch.await(2, TimeUnit.SECONDS)

    if (!verify) {
        Assert.fail("LiveData observer  not triggered")
    }
}

fun <T> LiveData<T>.await(timeout: Long = 2) {
    val latch = CountDownLatch(1)

    var verify = false

    var observer: Observer<T>? = null

    observer = Observer {
        latch.countDown()
        verify = true
        this.removeObserver(observer!!)
    }

    this.observeForever(observer)

    latch.await(timeout, TimeUnit.SECONDS)

    if (!verify) {
        Assert.fail("LiveData wait timeout")
    }
}