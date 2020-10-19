package com.btgpactual.teste.mobile_challenge.di

import androidx.lifecycle.ViewModel
import com.btgpactual.teste.mobile_challenge.ui.loading.LoadingViewModel
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap

/**
 * Created by Carlos Souza on 16,October,2020
 */
@Module
abstract class LoadingViewModelsModule {

    @Binds
    @IntoMap
    @ViewModelKey(LoadingViewModel::class)
    abstract fun bindLoadingViewModel(loadingViewModel: LoadingViewModel): ViewModel
}