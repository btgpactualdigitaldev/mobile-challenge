package com.lucasnav.desafiobtg.modules.currencyConverter.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.lucasnav.desafiobtg.R
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.view.holder.CurrencyViewHolder

class CurrenciesAdapter(
    private val clickListener: (currecyId: String) -> Unit
) : RecyclerView.Adapter<CurrencyViewHolder>() {

    private var currencies: List<Currency> = emptyList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_currency, parent, false)
        return CurrencyViewHolder(
            view
        )
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.bind(currencies[position], clickListener)
    }

    fun update(currencies: List<Currency>) {
        this.currencies = currencies
        notifyDataSetChanged()
    }
}