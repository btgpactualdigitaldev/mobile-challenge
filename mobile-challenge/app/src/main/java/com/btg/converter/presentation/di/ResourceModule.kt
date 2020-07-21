package com.btg.converter.presentation.di

import com.btg.converter.domain.util.resource.Strings
import com.btg.converter.presentation.util.error.ErrorHandler
import com.btg.converter.presentation.util.logger.Logger
import org.koin.dsl.module

fun resourceModule() = module {

    single {
        Strings(get())
    }

    single {
        Logger(get())
    }

    single {
        ErrorHandler(get(), get())
    }
}
