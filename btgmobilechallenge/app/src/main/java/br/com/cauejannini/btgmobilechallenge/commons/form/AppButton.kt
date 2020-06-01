package br.com.cauejannini.btgmobilechallenge.commons.form

import android.content.Context
import android.graphics.PorterDuff
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import android.widget.ProgressBar
import android.widget.TextView
import androidx.core.content.ContextCompat
import br.com.cauejannini.btgmobilechallenge.R

class AppButton(context: Context?, attrs: AttributeSet?) : LinearLayout(context, attrs) {

    var textView: TextView
    var progressBar: ProgressBar
    var text: String? = null

    init {
        initializeAttrs(attrs)
        orientation = VERTICAL
        background = resources.getDrawable(R.drawable.app_button)

        // Adicionar view
        val child = LayoutInflater.from(context).inflate(R.layout.app_button, this, true)

        // Configurar estado inicial
        textView = child.findViewWithTag("textView")
        progressBar = child.findViewWithTag("progressBar")
        progressBar.indeterminateDrawable.setColorFilter(ContextCompat.getColor(context!!, R.color.white), PorterDuff.Mode.SRC_IN)

        text?.let { textView.text = it.toUpperCase() }
    }

    fun updateText(text: String) {
        this.text = text
        textView.text = text
    }

    private fun initializeAttrs(attrs: AttributeSet?) {

        val typedArray = context.obtainStyledAttributes(attrs, R.styleable.AppButton)

        text = typedArray.getString(R.styleable.AppButton_text)
        typedArray.recycle()
    }

    override fun setEnabled(enabled: Boolean) {
        super.setEnabled(enabled)
        isClickable = enabled
    }

    fun setLoading(loading: Boolean) {
        if (loading) {
            isClickable = false
            textView.visibility = View.INVISIBLE
            progressBar.visibility = View.VISIBLE
        } else {
            progressBar.visibility = View.INVISIBLE
            textView.visibility = View.VISIBLE
            isClickable = true
        }
    }
}