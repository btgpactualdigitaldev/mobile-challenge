package br.com.rcp.currencyconverter

import android.app.Application
import br.com.rcp.currencyconverter.injection.components.ApplicationComponent
import br.com.rcp.currencyconverter.injection.components.DaggerApplicationComponent

class Converter : Application() {
    init {
        context = this
    }

    companion object {
        private lateinit var context: Application
        val	component : ApplicationComponent by lazy { DaggerApplicationComponent.factory().create(context) }
    }
}