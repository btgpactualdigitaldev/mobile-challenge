package br.com.btg.test.feature.currency.ui

import android.os.Bundle
import br.com.btg.test.base.BaseActivity
import br.com.btg.test.feature.currency.di.CurrencyModule
import br.com.btg.test.feature.currency.ui.fragments.CurrencyFragment
import br.com.btg.test.R
import org.koin.core.module.Module

class CurrencyActivity : BaseActivity() {

    override val modules: List<Module> = listOf(CurrencyModule.modules)
    override val contentView: Int = R.layout.main_activity

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        supportFragmentManager.beginTransaction().replace(
            R.id.container,
            CurrencyFragment.newInstance(), "tag"
        ).commit()
    }

}