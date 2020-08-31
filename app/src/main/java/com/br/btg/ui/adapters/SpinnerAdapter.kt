package com.br.btg.ui.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.br.btg.R
import com.br.btg.data.models.Currency
import kotlinx.android.synthetic.main.custom_adapter_list_coins.view.*

class ListCoinsAdapter(
    private val context: Context,
    private val currencies: MutableList<Currency> = mutableListOf(),
    var clickListener: (coin: Currency) -> Unit = {}
) : RecyclerView.Adapter<ListCoinsAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val viewCriada = LayoutInflater.from(context).inflate(R.layout.custom_adapter_list_coins, parent, false)
        return ViewHolder(viewCriada)
    }

    override fun getItemCount() = currencies.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val coin = currencies[position]
        holder.vincula(coin, clickListener)
    }

    fun atualiza(coins: List<Currency>) {
        notifyItemRangeRemoved(0, this.currencies.size)
        this.currencies.clear()
        this.currencies.addAll(coins)
        notifyItemRangeInserted(0, this.currencies.size)
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        private lateinit var currency: Currency

        fun vincula(coin: Currency,  clickListener: (Currency) -> Unit) {
            this.currency = coin
            itemView.textview_description_coin.text = currency.name
            itemView.textview_name_coin.text = currency.value
            itemView.setOnClickListener { clickListener(currency) }

        }

    }

}
