package com.a.coinmaster.di

import com.a.coinmaster.view.CoinListActivity
import com.a.coinmaster.view.MainActivity
import dagger.Component

@Component(modules = [CoinMasterModule::class])
interface CoinMasterComponent {
    fun inject(mainActivity: MainActivity)
    fun inject(coinListActivity: CoinListActivity)
}