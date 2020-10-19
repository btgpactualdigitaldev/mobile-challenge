package com.btgpactual.teste.mobile_challenge.di

import com.btgpactual.teste.mobile_challenge.ui.loading.LoadingActivity
import com.btgpactual.teste.mobile_challenge.ui.main.MainActivity
import com.btgpactual.teste.mobile_challenge.ui.main.dialog.CurrencyListDialog
import dagger.Module
import dagger.android.ContributesAndroidInjector

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Module
abstract class ActivityBuildersModule {

    @ContributesAndroidInjector(
        modules = [LoadingViewModelsModule::class]
    )
    abstract fun contributeLoadingActivity(): LoadingActivity

    @ContributesAndroidInjector(
        modules = [MainViewModelsModule::class]
    )
    abstract fun contributeMainActivity(): MainActivity

    @ContributesAndroidInjector
    abstract fun contributeCurrencyListDialog(): CurrencyListDialog
}