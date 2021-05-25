package br.com.btg.test.feature.currency.ui

import android.content.Intent
import android.os.Bundle
import br.com.btg.test.base.BaseActivity
import br.com.btg.test.base.BaseFragment
import br.com.btg.test.feature.currency.ui.fragments.CurrenciesListFragment

import br.com.btg.test.R
import org.koin.core.module.Module

class CurrenciesListActivity : BaseActivity() {


    companion object {
        fun startWithRequestCode(
            fragment: BaseFragment,
            requestCode: Int
        ) {
            fragment.startActivityForResult(
                Intent(fragment.context, CurrenciesListActivity::class.java),
                requestCode
            )
        }
    }

    override val modules: List<Module> = listOf()
    override val contentView = R.layout.activity_currencies_list

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        supportFragmentManager.beginTransaction()
            .replace(R.id.container, CurrenciesListFragment.newInstance())
            .commitNow()

    }


}