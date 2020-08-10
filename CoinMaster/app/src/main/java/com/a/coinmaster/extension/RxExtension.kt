package com.a.coinmaster.extension

import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

fun <T> makeRequest(func: () -> Single<T>): Single<T> =
    func
        .invoke()
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())