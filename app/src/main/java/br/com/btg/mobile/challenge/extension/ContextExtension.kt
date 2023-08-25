package br.com.btg.mobile.challenge.extension

import android.app.Activity
import android.content.Context
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.core.content.ContextCompat
import br.com.btg.mobile.challenge.R

fun Context.message(text: String) {
    Toast.makeText(this, text, Toast.LENGTH_LONG).show()
}

fun Activity.startActivity(clazz: Class<*>, finishing: Boolean = true, bundle: Bundle? = null) {
    startActivity(
        Intent(this, clazz).apply {
            bundle?.let { putExtras(it) }
        }
    )
    if (finishing) finish()
}

fun Context.dialog(
    title: String,
    message: String,
    listener: ((dialog: DialogInterface, wich: Int) -> Unit)? = null
) {
    val dialog: AlertDialog =
        AlertDialog.Builder(this, R.style.DesignAppThemeLightDialogAlert)
            .setTitle(title)
            .setMessage(message)
            .setPositiveButton(R.string.okay, listener)
            .create()

    dialog.show()
    dialog.getButton(AlertDialog.BUTTON_POSITIVE)
        .setTextColor(ContextCompat.getColor(this, R.color.primary_color))
}
