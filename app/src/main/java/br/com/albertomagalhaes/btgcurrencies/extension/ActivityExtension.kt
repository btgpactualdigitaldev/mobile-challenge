package br.com.albertomagalhaes.btgcurrencies.extension

import android.app.Activity
import android.content.DialogInterface
import android.widget.Toast
import androidx.annotation.StringRes
import androidx.appcompat.app.AlertDialog
import br.com.albertomagalhaes.btgcurrencies.R

fun Activity.showSimpleDialog(
    title:String = getString(R.string.alert),
    message:String,
    primaryButtonName : String = getString(R.string.ok),
    secondaryButtonName : String? = null,
    primaryAction:((DialogInterface) -> Unit)? = { it.dismiss() },
    secondaryAction:((DialogInterface) -> Unit)? = null
){
    AlertDialog.Builder(this).apply {
        setTitle(title)
        setMessage(message)
        setCancelable(false)
        setPositiveButton(primaryButtonName) { dialog, which ->
            primaryAction?.invoke(dialog)
        }
        if(!secondaryButtonName.isNullOrBlank()){
            setNeutralButton(secondaryButtonName) { dialog, which ->
                secondaryAction?.invoke(dialog)
            }
        }
        show()
    }
}

fun Activity.showSimpleMessage(@StringRes messageRes: Int){
    Toast.makeText(this, getString(messageRes), Toast.LENGTH_SHORT).show()
}

