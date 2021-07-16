package br.com.conversordemoedas.di

import br.com.conversordemoedas.model.ListManager
import br.com.conversordemoedas.model.Database
import br.com.conversordemoedas.model.LiveManager
import br.com.conversordemoedas.model.QuotesManager
import br.com.conversordemoedas.utils.Network
import br.com.conversordemoedas.viewmodel.CurrencyViewModel
import org.koin.android.viewmodel.ext.koin.viewModel
import org.koin.dsl.module.module

object DependencyModules {

    val appModule = module {

        single { Network() }

        single { Database() }

        factory { ListManager( get() ) }

        factory { LiveManager( get() ) }

        factory { QuotesManager() }

        viewModel { CurrencyViewModel( get(), get(), get() ) }

    }

}