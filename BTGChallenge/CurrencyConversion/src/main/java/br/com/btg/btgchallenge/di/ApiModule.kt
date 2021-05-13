package br.com.btg.btgchallenge.di

import br.com.btg.btgchallenge.network.BuildConfig
import br.com.btg.btgchallenge.network.api.config.NetworkUtils
import br.com.btg.btgchallenge.network.api.config.RequestInterceptor
import br.com.btg.btgchallenge.network.api.config.ResponseHandler
import br.com.btg.btgchallenge.network.api.currencylayer.CurrencyLayerRepository
import br.com.btg.btgchallenge.network.api.currencylayer.CurrencyLayerServices
import br.com.btg.btgchallenge.network.api.currencylayer.CurrencyRepositoryLocal
import org.koin.dsl.module

val apiModule = module {
    factory { RequestInterceptor() }
    factory { NetworkUtils.provideOkHttpClient(get()) }
    factory { NetworkUtils.provideRetrofit(webServiceApi = CurrencyLayerServices::class.java, apiUrl = BuildConfig.CURRENCY_LAYER_URL, okHttpClient = get()) }
    factory { ResponseHandler() }


    single  { CurrencyLayerRepository(get(), get(), get(), get()) }
    single  { CurrencyRepositoryLocal(get()) }
}