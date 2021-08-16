package com.br.cambio.customviews

import android.text.InputType
import android.view.View
import android.widget.EditText

fun FormField.setOnFieldClickListener(callback: () -> Unit) {
    post {
        overrideOnClickListener(callback)
        editText?.overrideOnClickListener(callback)
    }
}

private fun View.overrideOnClickListener(callback: () -> Unit) {
    isFocusable = false
    if(this is EditText) inputType = InputType.TYPE_NULL
    setOnClickListener { callback() }
}