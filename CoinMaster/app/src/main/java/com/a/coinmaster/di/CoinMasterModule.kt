package com.a.coinmaster.di

import com.a.coinmaster.api.CoinMasterApi
import com.a.coinmaster.api.retrofit.RetrofitConfig
import com.a.coinmaster.model.mapper.CurrenciesListMapper
import com.a.coinmaster.model.mapper.CurrencyMapper
import com.a.coinmaster.model.mapper.Mapper
import com.a.coinmaster.model.response.CurrenciesListResponse
import com.a.coinmaster.model.response.CurrencyResponse
import com.a.coinmaster.model.vo.CurrenciesListVO
import com.a.coinmaster.repository.CoinMasterRepository
import com.a.coinmaster.usecase.CalculateTargetValueUseCase
import com.a.coinmaster.usecase.GetCurrenciesListUseCase
import com.a.coinmaster.usecase.GetCurrencyUseCase
import com.a.coinmaster.viewmodel.CoinListViewModel
import com.a.coinmaster.viewmodel.MainViewModel
import dagger.Module
import dagger.Provides

@Module
class CoinMasterModule {
    @Provides
    fun providesServiceApi(): CoinMasterApi = RetrofitConfig()
        .getServiceApi(CoinMasterApi::class.java)

    @Provides
    fun providesMainViewModel(
        currencyUseCase: GetCurrencyUseCase,
        calculateTargetValueUseCase: CalculateTargetValueUseCase
    ) = MainViewModel(currencyUseCase, calculateTargetValueUseCase)

    @Provides
    fun providesCoinListViewModel(
        getCurrenciesListUseCase: GetCurrenciesListUseCase
    ) = CoinListViewModel(getCurrenciesListUseCase)

    @Provides
    fun providesCalculateUseCase() = CalculateTargetValueUseCase()

    @Provides
    fun providesCurrencyUseCase(
        repository: CoinMasterRepository,
        mapper: Mapper<CurrencyResponse, CurrenciesListVO>
    ) = GetCurrencyUseCase(repository, mapper)

    @Provides
    fun providesCurrenciesListUseCase(
        repository: CoinMasterRepository,
        mapper: Mapper<CurrenciesListResponse, CurrenciesListVO>
    ) = GetCurrenciesListUseCase(repository, mapper)

    @Provides
    fun providesCurrencyMapper(): Mapper<CurrencyResponse, CurrenciesListVO> =
        CurrencyMapper()

    @Provides
    fun providesCurrenciesListMapper(): Mapper<CurrenciesListResponse, CurrenciesListVO> =
        CurrenciesListMapper()

    @Provides
    fun providesRepository(
        serviceApi: CoinMasterApi
    ) = CoinMasterRepository(serviceApi)
}