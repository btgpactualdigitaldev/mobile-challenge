package com.gui.antonio.testebtg.di

import android.app.Activity
import android.content.Context
import com.gui.antonio.testebtg.view.MainActivity
import dagger.BindsInstance
import dagger.Component

@Component(modules = [AppModule::class])
interface AppComponent {

    @Component.Factory
    interface Factory {
        fun create(@BindsInstance context: Context, @BindsInstance activity: MainActivity): AppComponent
    }

    fun inject(activity: MainActivity)
}