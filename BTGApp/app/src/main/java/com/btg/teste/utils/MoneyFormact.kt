package com.btg.teste.utils

import java.text.NumberFormat
import java.util.*

object MoneyFormact {

    @JvmStatic
    fun mask(cash: Double): String {
        var valor = cash

        if (java.lang.Double.isNaN(valor))
            valor = 0.0

        val ptBr = Locale("pt", "BR")
        return NumberFormat.getCurrencyInstance(ptBr).format(valor)
    }
}