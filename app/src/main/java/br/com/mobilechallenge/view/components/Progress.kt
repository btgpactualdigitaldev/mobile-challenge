package br.com.mobilechallenge.view.components

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.content.ContextCompat

import br.com.mobilechallenge.R

class Progress(context: Context, attrs: AttributeSet) : LinearLayout(context, attrs) {
    lateinit var view: View
    lateinit var textView: TextView

    init {
        start()
    }

    private fun start() {
        // seta o Background
        setBackgroundColor(ContextCompat.getColor(context, android.R.color.transparent))

        // pega o inflater
        val inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater

        // pega a View
        view = inflater.inflate(R.layout.progress, this)

        textView = view.findViewById(R.id.txtProgress)
    }

    fun show() { view.visibility = View.VISIBLE }
    fun hide() { view.visibility = View.GONE    }

    fun setText(msg: String) { textView.text = msg }
    fun setText(msg: Int)    { textView.text = context.getString(msg) }
}