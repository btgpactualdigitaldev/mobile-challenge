package br.com.conversordemoedas.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.conversordemoedas.R
import br.com.conversordemoedas.model.Currency
import kotlinx.android.synthetic.main.item_currency.view.*

class CurrencyViewHolder (private val view: View): RecyclerView.ViewHolder(view){
    fun bindView(item: Currency){
        with(view){
            tv_currency_key.text = item.code
            tv_currency_name.text = item.name
        }
    }
}

class CurrencyAdapter (private val data: MutableList<Currency> = mutableListOf()):
    RecyclerView.Adapter<CurrencyViewHolder>(){
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_currency, parent, false)
        return CurrencyViewHolder(view)
    }

    override fun getItemCount(): Int = data.size

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) = holder.bindView(data[position])

    fun add(items: List<Currency>){
        data.clear()
        data.addAll(items)
        notifyDataSetChanged()
    }
}