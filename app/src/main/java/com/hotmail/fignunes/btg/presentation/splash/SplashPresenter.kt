package com.hotmail.fignunes.btg.presentation.splash

import com.hotmail.fignunes.btg.common.BasePresenter
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import java.util.concurrent.TimeUnit

class SplashPresenter(
    private val contract: SplashContract
) : BasePresenter() {

    fun onCreate() {
        Single.timer(2, TimeUnit.SECONDS)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({ contract.displayQuoteDollar() }, {})
            .also { addDisposable(it) }
    }
}