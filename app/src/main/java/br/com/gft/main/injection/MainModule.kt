package br.com.gft.main.injection

import br.com.gft.extension.resolveRetrofit
import br.com.gft.main.MainViewModel
import br.com.gft.main.PickCurrencyViewModel
import br.com.gft.main.interactor.CurrencyConverterUseCase
import br.com.gft.main.interactor.CurrencyConverterUseCaseImpl
import br.com.gft.main.interactor.GetCurrencyListUseCase
import br.com.gft.main.interactor.GetCurrencyListUseCaseImpl
import br.com.gft.main.service.CurrencyLayerService
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

object MainModule {
    val dependencyModule = module {
        viewModel {MainViewModel(get())}
        viewModel {PickCurrencyViewModel(get())}

        single<CurrencyLayerService> { resolveRetrofit() }

        factory<GetCurrencyListUseCase> { GetCurrencyListUseCaseImpl(get()) }
        factory<CurrencyConverterUseCase> { CurrencyConverterUseCaseImpl(get()) }
    }
}