package com.btg.converter.presentation.view.splash

import com.btg.converter.presentation.util.base.BaseViewModel
import com.btg.converter.presentation.util.constants.SPLASH_DELAY
import com.btg.converter.presentation.view.converter.ConverterNavData
import kotlinx.coroutines.delay

class SplashViewModel : BaseViewModel() {

    init {
        launchDataLoad {
            delay(SPLASH_DELAY)
            goTo(ConverterNavData())
        }
    }
}