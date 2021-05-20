package com.br.mobilechallenge.view.currencies.adapter.viewholder

import android.view.View
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.br.mobilechallenge.R

class CurrenciesViewHolder(view: View) : RecyclerView.ViewHolder(view) {

    val currencyName by lazy { itemView.findViewById<TextView>(R.id.currencies_rv_name) }
    val currencyCode by lazy { itemView.findViewById<TextView>(R.id.currencies_rv_code) }
}