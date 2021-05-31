package com.example.desafiobtg.di

import org.koin.core.module.Module

object AppComponent {

    fun getAllModules(): List<Module> =
            listOf(*getViewModelModules(), *getRepositoriesModules(), *getModules())

    private fun getViewModelModules(): Array<Module> = arrayOf(viewModelModule)

    private fun getRepositoriesModules(): Array<Module> = arrayOf(repositoriesModule)

    private fun getModules(): Array<Module> = arrayOf(modules)
}