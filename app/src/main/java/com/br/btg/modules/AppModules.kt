package com.br.btg.modules

import android.content.SharedPreferences
import com.br.btg.data.network.webclient.CurrencyLayerWebClient
import com.br.btg.data.repositories.CurrencyLayerRepository
import com.br.btg.ui.viewmodels.ConversorViewModel
import com.br.btg.utils.DEFAULT
import org.koin.android.ext.koin.androidApplication
import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module



val appModules = module {


    single<CurrencyLayerWebClient> {
        CurrencyLayerWebClient()
    }

    single<CurrencyLayerRepository> {
        CurrencyLayerRepository(get())
    }

    single{
        androidApplication().getSharedPreferences(DEFAULT,  android.content.Context.MODE_PRIVATE)
    }

    single<SharedPreferences.Editor> {
        androidApplication().getSharedPreferences(DEFAULT,  android.content.Context.MODE_PRIVATE).edit()
    }

    viewModel<ConversorViewModel> { ConversorViewModel(get()) }

}
