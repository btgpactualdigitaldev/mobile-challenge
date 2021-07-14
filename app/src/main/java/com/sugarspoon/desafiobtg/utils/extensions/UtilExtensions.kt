package com.sugarspoon.desafiobtg.utils.extensions

import android.content.Context
import android.content.res.ColorStateList
import androidx.core.content.ContextCompat

fun Int.toStateList() = ColorStateList.valueOf(this)

fun Context.getColorRes(idRes: Int): Int {
    return ContextCompat.getColor(this, idRes)
}