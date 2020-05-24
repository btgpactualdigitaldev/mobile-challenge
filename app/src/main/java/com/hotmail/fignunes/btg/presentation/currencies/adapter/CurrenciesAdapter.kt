package com.hotmail.fignunes.btg.presentation.currencies.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView
import com.hotmail.fignunes.btg.R
import com.hotmail.fignunes.btg.model.Currency

class CurrenciesAdapter(
    private val context: Context,
    private val currencies: List<Currency>,
    private val clickCurrency: ClickCurrency
) :
    RecyclerView.Adapter<CurrenciesAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_currencies, parent, false)
        val holder = ViewHolder(view)
        view.setTag(holder)
        return holder
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val currency = currencies[position]
        holder.textView_code.setText(currency.id)
        holder.textView_description.setText(currency.description)
        holder.cardView.setOnClickListener { clickCurrency.click(currency) }
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    interface ClickCurrency {
        fun click(currency: Currency)
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        internal var cardView: CardView
        internal var textView_code: TextView
        internal var textView_description: TextView

        init {
            cardView = itemView.findViewById(R.id.itemCurrenciesCardview) as CardView
            textView_code = itemView.findViewById(R.id.itemCurrenciesCode) as TextView
            textView_description = itemView.findViewById(R.id.itemCurrenciesDescription) as TextView

        }
    }
}