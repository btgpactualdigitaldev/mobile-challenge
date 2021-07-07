package br.net.easify.currencydroid.di.component

import br.net.easify.currencydroid.MainApplication
import br.net.easify.currencydroid.di.module.AppModule
import br.net.easify.currencydroid.services.RateService
import br.net.easify.currencydroid.view.MainActivity
import br.net.easify.currencydroid.viewmodel.CurrenciesViewModel
import br.net.easify.currencydroid.viewmodel.HomeViewModel
import dagger.Component
import javax.inject.Singleton

@Singleton
@Component(modules = [AppModule::class])
interface AppComponent {
    @Component.Builder
    interface Builder {
        fun application(app: AppModule): Builder
        fun build(): AppComponent
    }

    fun inject(app: MainApplication)
    fun inject(viewModel: HomeViewModel)
    fun inject(viewModel: CurrenciesViewModel)
    fun inject(service: RateService)
    fun inject(activity: MainActivity)
}