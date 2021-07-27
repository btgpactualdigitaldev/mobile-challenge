package io.felipeandrade.currencylayertest.ui

import android.text.Editable
import android.text.TextWatcher
import java.util.*


class DelayedTextChangeWatcher(private val task: ()-> Unit) : TextWatcher {

    private var timer: Timer = Timer()


    override fun afterTextChanged(s: Editable?) {
        timer = Timer()
        timer.schedule(object : TimerTask() {
            override fun run() {
                task.invoke()
            }

        }, 600)
    }

    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
    }

    override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
        timer.cancel()
    }
}