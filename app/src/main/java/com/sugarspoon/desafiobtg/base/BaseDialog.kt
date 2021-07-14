package com.sugarspoon.desafiobtg.base

import android.content.Context
import android.content.DialogInterface
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.view.Window
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatDialog

open class BaseDialog : AppCompatDialog {

    constructor(context: Context?) : super(context)

    constructor(context: Context, theme: Int) : super(context, theme)

    constructor(context: Context, cancelable: Boolean, cancelListener: DialogInterface.OnCancelListener) :
        super(context, cancelable, cancelListener)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window?.requestFeature(Window.FEATURE_NO_TITLE)
        window?.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
    }

    protected fun setWidthToMatchWindowsSize(height: Int = LinearLayout.LayoutParams.WRAP_CONTENT) {
        window?.setLayout(LinearLayout.LayoutParams.MATCH_PARENT, height)
    }
}
