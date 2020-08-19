package com.kaleniuk2.conversordemoedas.extension

import android.app.Activity
import android.content.Context
import android.view.inputmethod.InputMethodManager
import android.widget.Toast

fun Activity.showText(text: String) {
    Toast.makeText(this, text, Toast.LENGTH_SHORT ).show()
}

fun Activity.hideKeyboard() {
    this.currentFocus?.let { v ->
        val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as? InputMethodManager
        imm?.hideSoftInputFromWindow(v.windowToken, 0)
    }
}