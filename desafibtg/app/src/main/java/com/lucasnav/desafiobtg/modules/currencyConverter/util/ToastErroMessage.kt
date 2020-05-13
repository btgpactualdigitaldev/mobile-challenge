package com.lucasnav.desafiobtg.modules.currencyConverter.util

import android.content.Context
import android.widget.Toast

fun showErrorToast(message: String, context: Context) {
    Toast.makeText(
        context,
        message,
        Toast.LENGTH_SHORT
    )
        .show()
}