package com.romildosf.currencyconverter.view.util

import android.app.Dialog
import android.content.Context
import androidx.appcompat.app.AlertDialog
import com.romildosf.currencyconverter.R
import java.lang.Exception

object LoadingDialog {
    private var currentDialog: Dialog? = null

    fun hide() {
        try {
            currentDialog?.dismiss()
        } catch (exc: Exception) {
            // Empty
        }
    }
    fun show(context: Context): Dialog {
        try {
            currentDialog = AlertDialog.Builder(context)
                .setView(R.layout.loading_view)
                .create()

            currentDialog?.show()
        } catch (exc: Exception) {
            // Empty
        }
        return currentDialog!!
    }
}