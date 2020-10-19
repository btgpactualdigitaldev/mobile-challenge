package com.btgpactual.teste.mobile_challenge.di

import androidx.lifecycle.ViewModel
import com.btgpactual.teste.mobile_challenge.ui.loading.LoadingViewModel
import com.btgpactual.teste.mobile_challenge.ui.main.MainViewModel
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap

/**
 * Created by Carlos Souza on 17,October,2020
 */
@Module
abstract class MainViewModelsModule {

    @Binds
    @IntoMap
    @ViewModelKey(MainViewModel::class)
    abstract fun bindMainViewModel(mainViewModel: MainViewModel): ViewModel

}