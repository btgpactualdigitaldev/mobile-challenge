package com.hotmail.fignunes.btg.common

import android.content.Context
import android.graphics.Color
import android.graphics.PorterDuff
import android.widget.Toast

class ToastCustom {

    companion object {
        fun execute(context: Context, message: String) {
            val toast = Toast.makeText(context, message, Toast.LENGTH_LONG)
            val view = toast.view
            view.background.setColorFilter(Color.parseColor("#0047AB"), PorterDuff.Mode.SRC_IN)
            toast.show()
        }
    }
}