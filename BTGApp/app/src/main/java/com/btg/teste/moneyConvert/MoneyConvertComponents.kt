package com.btg.teste.moneyConvert

import dagger.Component

@Component(modules = [MoneyConvertModule::class])
interface MoneyConvertComponents {
    fun inject(fragment: MoneyConvertFragment)
    fun inject(presenter: MoneyConvertPresenter)
}