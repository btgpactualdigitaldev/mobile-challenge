package com.example.desafiobtg.di

import com.example.desafiobtg.base.BaseRepository
import com.example.desafiobtg.repositories.ConvertRepository
import org.koin.dsl.module

val repositoriesModule = module {

    single<BaseRepository> { ConvertRepository(responseTreatment = get()) }
}