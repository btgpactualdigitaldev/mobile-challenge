package br.com.btgpactual.currencyconverter.ui.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.btgpactual.currencyconverter.R
import br.com.btgpactual.currencyconverter.data.model.Currency
import kotlinx.android.synthetic.main.item_currency.view.*

class CurrencyAdapter(private val currencies : List<Currency>) : RecyclerView.Adapter<CurrencyAdapter.CurrencyViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_currency,parent,false)
        return  CurrencyViewHolder(view)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        holder.bindView(currencies[position])
    }

    override fun getItemCount() = currencies.count()

    class CurrencyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView){

        private val code = itemView.item_currency_code_tv
        private val name = itemView.item_currency_name_tv

        fun bindView(currency: Currency){
            code.text = currency.code
            name.text = currency.name
        }
    }
}