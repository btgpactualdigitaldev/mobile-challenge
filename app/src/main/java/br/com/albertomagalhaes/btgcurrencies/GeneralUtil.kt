package br.com.albertomagalhaes.btgcurrencies

import android.content.Context
import android.content.res.Resources
import android.graphics.drawable.Drawable
import android.util.Log
import androidx.core.content.ContextCompat

fun getCurrencyImage(context: Context, currencyCode: String): Drawable? {
    try {
        val resources: Resources = context.resources
        val resourceId = resources.getIdentifier(
            Constant.CURRENCY_IMAGE_PREFIX + currencyCode,
            "drawable",
            context.packageName
        )
        return ContextCompat.getDrawable(context,resourceId)
    } catch (e: Exception) {
        Log.i(
            "Attention - Log:",
            "Currency not found: $currencyCode"
        )
        return ContextCompat.getDrawable(context,R.drawable.currency_unknown)
    }
}