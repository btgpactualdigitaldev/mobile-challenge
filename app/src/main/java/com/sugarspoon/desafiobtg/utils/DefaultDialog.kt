package com.sugarspoon.desafiobtg.utils

import android.content.Context
import android.os.Bundle
import com.sugarspoon.desafiobtg.R
import com.sugarspoon.desafiobtg.base.BaseDialog
import com.sugarspoon.desafiobtg.utils.extensions.getColorRes
import com.sugarspoon.desafiobtg.utils.extensions.setVisible
import com.sugarspoon.desafiobtg.utils.extensions.toStateList
import kotlinx.android.synthetic.main.dialog_default.*

class DefaultDialog(context: Context) : BaseDialog(context) {

    constructor(context: Context, title: String, body: String) : this(context) {
        this.title = title
        this.body = body
    }

    private var icon: Int? = null
    private var backgroundColor: Int? = null
    private var title: String? = null
    private var body: String? = null
    private var rightText: String? = null
    private var rightAction: (() -> Unit)? = null
    private var leftText: String? = context.getString(R.string.action_ok)
    private var leftAction: (() -> Unit)? = null
    private var dismissAction: (() -> Unit)? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.dialog_default)
        setWidthToMatchWindowsSize()
        setView()
    }

    override fun dismiss() {
        dismissAction?.invoke()
        super.dismiss()
    }

    private fun setView() {
        setLayout()
        setRightButton()
        setLeftButton()
    }

    private fun setLayout() {
        icon?.let { defDialogIconImageView.setImageResource(it) }

        defDialogTitleTv.text = title
        defDialogBodyTv.text = body

        backgroundColor?.let { colorRes ->
            context.getColorRes(colorRes)
        }?.let { colorInt ->
            defDialogLeftBtn.setTextColor(colorInt)
            defDialogContainerLayout.backgroundTintList = colorInt.toStateList()
        }
    }

    private fun setLeftButton() {
        defDialogLeftBtn.setText(leftText)
        defDialogLeftBtn.setOnClickListener {
            leftAction?.invoke()
            dismiss()
        }
    }

    private fun setRightButton() {
        defDialogRightBtn.setVisible(rightText != null)
        defDialogRightBtn.setText(rightText)
        defDialogRightBtn.setOnClickListener {
            rightAction?.invoke()
            dismiss()
        }
    }

    fun setIcon(icon: Int): DefaultDialog {
        this.icon = icon
        return this
    }

    fun setBackgroundColor(backgroundColor: Int): DefaultDialog {
        this.backgroundColor = backgroundColor
        return this
    }

    fun setTitle(title: String?): DefaultDialog {
        this.title = title
        return this
    }

    fun setBody(body: String?): DefaultDialog {
        this.body = body
        return this
    }

    fun setRightText(rightText: String?): DefaultDialog {
        this.rightText = rightText
        return this
    }

    fun setRightAction(rightAction: () -> Unit): DefaultDialog {
        this.rightAction = rightAction
        return this
    }

    fun setLeftText(leftText: String?): DefaultDialog {
        this.leftText = leftText
        return this
    }

    fun setLeftAction(leftAction: () -> Unit): DefaultDialog {
        this.leftAction = leftAction
        return this
    }

    fun setDismissAction(dismissAction: () -> Unit): DefaultDialog {
        this.dismissAction = dismissAction
        return this
    }

    fun showDialog(showDialog: Boolean) {
        if (showDialog) {
            show()
        }
    }
}
