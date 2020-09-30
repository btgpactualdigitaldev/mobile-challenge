package com.btgpactual.currencyconverter.util

import android.content.Context
import android.content.res.Resources
import android.graphics.drawable.Drawable
import android.util.Log
import androidx.appcompat.app.AlertDialog
import com.btgpactual.currencyconverter.R

fun showSimpleMessage(context: Context, message:String, title:String = context.getString(R.string.opening_activity_dialog_title_generic), dismissButtonText : String = context.getString(R.string.button_ok)) {
    val builder = AlertDialog.Builder(context)
    builder.setTitle(title)
    builder.setMessage(message)
    builder.setCancelable(false)
    builder.setPositiveButton(dismissButtonText) { dialog, which ->
        dialog.dismiss()
    }

    builder.show()
}

fun getFlag(context: Context, flagCode:String): Drawable?{
    try {
        val resources: Resources = context.resources
        val resourceId = resources.getIdentifier(
            "flag_$flagCode",
            "drawable",
            context.packageName
        )
        return context.getDrawable(resourceId)
    } catch (e: Exception) {
        Log.i(
            "BTGPactual",
            "Simbolo não encontrado: $flagCode"
        )
    }
    return null
}
