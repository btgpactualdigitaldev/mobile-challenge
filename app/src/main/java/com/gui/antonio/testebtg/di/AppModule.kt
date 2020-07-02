package com.gui.antonio.testebtg.di

import android.content.Context
import androidx.lifecycle.ViewModelProvider
import androidx.room.Room
import com.gui.antonio.testebtg.database.AppDatabase
import com.gui.antonio.testebtg.datasource.AccessDataSource
import com.gui.antonio.testebtg.model.AccessDatabase
import com.gui.antonio.testebtg.repository.AppRepository
import com.gui.antonio.testebtg.view.MainActivity
import com.gui.antonio.testebtg.viewmodel.MainViewModel
import com.gui.antonio.testebtg.viewmodel.MainViewModelFactory
import dagger.Module
import dagger.Provides

@Module
class AppModule {

    @Provides
    fun provideDatabase(context: Context): AppDatabase = Room.databaseBuilder(context, AppDatabase::class.java, "db_app").build()

    @Provides
    fun provideMainViewModel(context: Context, activity: MainActivity): MainViewModel {

        val dao = provideDatabase(context).appDao()
        val accessDatabase = AccessDatabase(dao)
        val datasource = AccessDataSource(accessDatabase)
        val repository = AppRepository(datasource)

        return ViewModelProvider(activity, MainViewModelFactory(repository)).get(MainViewModel::class.java)
    }
}