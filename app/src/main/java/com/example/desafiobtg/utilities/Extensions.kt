package com.example.desafiobtg.utilities

import android.content.Context
import android.widget.Spinner
import android.widget.Toast
import com.example.desafiobtg.utilities.Constants.Api.POSICAO
import java.text.NumberFormat
import java.util.*

fun Context.displayToast(message: String?) {
    Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
}

fun formatterNumber(result: Double): String {
    val ptBr = Locale("pt", "BR")
    return NumberFormat.getCurrencyInstance(ptBr).format(result)
}

fun currencyIsValid(spinner: Spinner, message: String): Boolean {

    return (spinner.getItemAtPosition(POSICAO) == message)
}

