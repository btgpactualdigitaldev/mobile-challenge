package com.btg.converter.presentation.util.click

import android.os.SystemClock
import android.view.View

class SafeClickListener(
    private val callback: () -> Unit,
    private var minInterval: Int = 1000
) : View.OnClickListener {

    private var lastTimeClicked: Long = 0

    override fun onClick(view: View) {
        if (SystemClock.elapsedRealtime() - lastTimeClicked < minInterval) return
        lastTimeClicked = SystemClock.elapsedRealtime()
        callback.invoke()
    }
}
