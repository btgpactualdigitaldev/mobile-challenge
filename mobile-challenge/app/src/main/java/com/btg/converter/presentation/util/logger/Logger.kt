package com.btg.converter.presentation.util.logger

import android.content.Context
import android.util.Log
import com.btg.converter.BuildConfig
import com.btg.converter.R

class Logger constructor(context: Context) {

    private val tag = context.getString(R.string.app_name)

    fun e(tr: Throwable) {
        if (BuildConfig.DEBUG) Log.e(tag, tr.message, tr)
    }
}
