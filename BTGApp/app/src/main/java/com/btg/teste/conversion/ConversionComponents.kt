package com.btg.teste.conversion

import dagger.Component

@Component(modules = [ConversionModule::class])
interface ConversionComponents {
    fun inject(fragment: ConversionsFragment)
    fun inject(presenter: ConversionPresenter)
    fun inject(interactor: ConversionInteractor)
}