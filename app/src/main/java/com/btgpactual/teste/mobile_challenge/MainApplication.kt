package com.btgpactual.teste.mobile_challenge

import com.btgpactual.teste.mobile_challenge.di.DaggerAppComponent
import dagger.android.AndroidInjector
import dagger.android.DaggerApplication

/**
 * Created by Carlos Souza on 16,October,2020
 */
open class  MainApplication: DaggerApplication() {

    override fun applicationInjector(): AndroidInjector<out DaggerApplication> {
        return DaggerAppComponent.builder().mainApplication(this).build()
    }

}