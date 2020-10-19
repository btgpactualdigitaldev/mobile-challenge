package com.btgpactual.teste.mobile_challenge.di

import com.btgpactual.teste.mobile_challenge.data.preferences.IPreferences
import com.btgpactual.teste.mobile_challenge.data.preferences.PreferencesData
import dagger.Binds
import dagger.Module

/**
 * Created by Carlos Souza on 01,June,2020
 */
@Module
abstract class PreferencesModule {

    @Binds
    abstract fun providesPreferences(preferences: PreferencesData): IPreferences
}