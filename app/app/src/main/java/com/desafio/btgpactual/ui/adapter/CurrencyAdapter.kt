package com.desafio.btgpactual.ui.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.desafio.btgpactual.R
import com.desafio.btgpactual.shared.models.CurrencyModel
import kotlinx.android.synthetic.main.item_currency.view.*


class CurrencyAdapter(private val currencies: List<CurrencyModel>
                      ,private val context: Context): RecyclerView.Adapter<CurrencyAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.item_currency, parent, false)
        return ViewHolder(view)
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val currency = currencies[position]
        holder.bind(currency)
    }

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun bind(currencyModel: CurrencyModel){
            val code = itemView.item_code
            val country = itemView.item_country
            code.text = currencyModel.code
            country.text = currencyModel.country
        }
    }
}

