package com.btg.converter.presentation.view.converter

import android.content.Context
import com.btg.converter.presentation.util.navigation.NavData

class ConverterNavData : NavData {

    override fun navigate(context: Context) {
        context.startActivity(ConverterActivity.createIntent(context))
    }
}