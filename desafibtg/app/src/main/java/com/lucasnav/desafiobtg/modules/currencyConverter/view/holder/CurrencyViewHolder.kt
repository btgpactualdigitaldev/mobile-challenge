package com.lucasnav.desafiobtg.modules.currencyConverter.view.holder

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import kotlinx.android.synthetic.main.item_currency.view.*

class CurrencyViewHolder(private val view: View) : RecyclerView.ViewHolder(view) {

    fun bind(
        currency: Currency,
        clickListener: (currencySymbol: String) -> Unit
    ) {
        with(view) {
            textViewName.text = currency.name
            textViewSymbol.text = currency.symbol
            setOnClickListener { clickListener(currency.symbol) }
        }
    }
}