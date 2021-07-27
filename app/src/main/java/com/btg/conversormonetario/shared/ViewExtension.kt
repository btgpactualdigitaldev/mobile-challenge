package com.btg.conversormonetario.shared

import android.app.AlertDialog
import android.graphics.Color
import android.graphics.Point
import android.graphics.drawable.ColorDrawable
import android.view.LayoutInflater
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.btg.conversormonetario.R
import com.btg.conversormonetario.view.listener.OnSingleClickListener
import kotlinx.android.synthetic.main.custom_dialog.view.*

fun View.setOnSingleClickListener(actionClicked: () -> Unit) {
    this.setOnClickListener(object : OnSingleClickListener() {
        override fun onSingleClick(v: View?) {
            actionClicked.invoke()
        }
    })
}

fun getWidthSizeScreen(context: AppCompatActivity): Float {
    val size = Point()
    context.windowManager.defaultDisplay.getSize(size)
    return size.x.toFloat()
}

fun warningDialog(
    context: AppCompatActivity,
    title: String, message: String,
    positiveButtonText: String, positiveClick: () -> Unit
) {
    val builder = AlertDialog.Builder(context)
    var alertDialog: AlertDialog? = null
    val dialogView = LayoutInflater.from(context).inflate(
        R.layout.custom_dialog, context.findViewById(android.R.id.content)
        , false
    )

    dialogView.tvwCustomDialogTitle.text = title
    dialogView.tvwCustomDialogMessage.text = message

    dialogView.btnCustomDialogPositiveAction.text = positiveButtonText
    dialogView.btnCustomDialogPositiveAction.setOnClickListener {
        alertDialog?.dismiss()
        positiveClick.invoke()
    }
    dialogView.btnCustomDialogPositiveAction.setOnClickListener {
        alertDialog?.dismiss()
    }

    builder.setView(dialogView)
    alertDialog = builder.create()
    alertDialog.window!!.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
    alertDialog.show()
}