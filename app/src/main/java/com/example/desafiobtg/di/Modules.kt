package com.example.desafiobtg.di

import com.example.desafiobtg.network.api.ApiBuilder
import com.example.desafiobtg.network.response.ResponseCall
import com.example.desafiobtg.network.response.ResponseTreatment
import com.example.desafiobtg.ui.convert.ConvertCalc
import org.koin.dsl.module

val modules = module {
    single { ResponseCall() }
    single { ApiBuilder() }
    single { ResponseTreatment(responseCall = get()) }
    single { ConvertCalc() }

}