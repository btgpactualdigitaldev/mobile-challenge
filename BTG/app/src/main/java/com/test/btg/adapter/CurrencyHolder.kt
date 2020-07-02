package com.test.btg.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.test.btg.R

class CurrencyHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

    private val textViewCurrency = itemView.findViewById<TextView>(R.id.textview_currency)
    private val textViewValue = itemView.findViewById<TextView>(R.id.textview_value)

    fun bind(currency: String, value: Double) {
        textViewCurrency.text = currency
        textViewValue.text = value.toString()
    }

    companion object {
        fun newInstance(viewGroup: ViewGroup) = CurrencyHolder(
            LayoutInflater
                .from(viewGroup.context)
                .inflate(R.layout.holder_currency, viewGroup, false)
        )
    }
}