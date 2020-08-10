package com.a.coinmaster.extension

import android.view.View

fun View.changeVisibility(isVisible: Boolean) {
    this.visibility = if (isVisible) {
        View.VISIBLE
    } else {
        View.GONE
    }
}