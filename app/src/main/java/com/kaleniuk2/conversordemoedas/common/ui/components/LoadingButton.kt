package com.kaleniuk2.conversordemoedas.common.ui.components

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.FrameLayout
import android.widget.ProgressBar
import com.kaleniuk2.conversordemoedas.R

class LoadingButton @JvmOverloads constructor(
    context: Context,
    attributeSet: AttributeSet? = null,
    defStyleAttr: Int = 0
) : FrameLayout(context, attributeSet, defStyleAttr) {

    private lateinit var button: Button
    private lateinit var progressBar: ProgressBar
    private val title: String
    private val showProgress: Boolean
    private val enabled: Boolean

    init {
        context.theme.obtainStyledAttributes(
            attributeSet,
            R.styleable.LoadingButton,
            0,0
        ).apply {
            title = getString(R.styleable.LoadingButton_title) ?: ""
            showProgress = getBoolean(R.styleable.LoadingButton_showProgress, false)
            enabled = getBoolean(R.styleable.LoadingButton_enabled, true)

            recycle()
        }

        this.configure()
    }

    private fun configure() {
        LayoutInflater.from(context).inflate(R.layout.loading_button_layout, this, true)

        button = getChildAt(0) as Button
        progressBar = getChildAt(1) as ProgressBar

        button.id = id
        button.isEnabled = enabled
        button.text = title
        progressBar.visibility = if(showProgress) View.VISIBLE else View.GONE

    }

    fun setTitle(text: String) {
        button.text = text
    }

    fun showLoading(show: Boolean) {
        progressBar.visibility = if(show) View.VISIBLE else View.GONE
        button.text = if (show) "" else title
    }

    override fun setEnabled(enabled: Boolean) {
        button.isEnabled = enabled
    }

    override fun setOnClickListener(l: OnClickListener?) {
        button.setOnClickListener(l)
    }
}
