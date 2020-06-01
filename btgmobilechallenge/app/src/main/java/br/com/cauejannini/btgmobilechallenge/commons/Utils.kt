package br.com.cauejannini.btgmobilechallenge.commons

import android.content.Context
import android.widget.Toast
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.text.NumberFormat
import java.text.ParseException
import java.util.*

object Utils {

    fun showToast(context: Context?, text: String?) {

        if (context != null && text != null) {
            Toast.makeText(context, text, Toast.LENGTH_SHORT).show()
        }
    }

    fun valorMonetarioParaDouble(valor: String?): Double? {
        if (valor != null) {

            val df = DecimalFormat("#,##0.00")
            try {
                val number = df.parse(valor)
                number?.let{
                    return it.toDouble()
                }
            } catch (e: ParseException) {
                e.printStackTrace()
            }
        }
        return null
    }

    fun doubleParaValorMonetario(valor: Double?): String {
        valor?.let{
            val df = DecimalFormat("#,##0.00")
            return df.format(it)
        }
        return "-"
    }

    fun doisDecimais(valor: Double?): String? {
        if (valor != null) {
            val decimalFormat = DecimalFormat(
                "#,##0.00",
                DecimalFormatSymbols(Locale("pt", "BR"))
            )
            return decimalFormat.format(valor)
        }
        return "-"
    }

}