package br.com.btg.mobile.challenge.di

import br.com.btg.mobile.challenge.BuildConfig
import br.com.btg.mobile.challenge.data.remote.MobileChallengeApi
import br.com.btg.mobile.challenge.data.remote.RetrofitConfig
import br.com.btg.mobile.challenge.data.repository.PriceRepository
import br.com.btg.mobile.challenge.data.repository.PriceRepositoryImp
import br.com.btg.mobile.challenge.data.repository.RateRepository
import br.com.btg.mobile.challenge.data.repository.RateRepositoryImp
import br.com.btg.mobile.challenge.ui.HomeViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val appModule = module {

    single {
        RetrofitConfig.buildApi(BuildConfig.BASE_URL).create(MobileChallengeApi::class.java)
    }

    single<RateRepository> { RateRepositoryImp(get()) }
    single<PriceRepository> { PriceRepositoryImp(get()) }

    viewModel { HomeViewModel(get(), get()) }
}
