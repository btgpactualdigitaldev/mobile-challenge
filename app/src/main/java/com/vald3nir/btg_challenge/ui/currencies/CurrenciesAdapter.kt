package com.vald3nir.btg_challenge.ui.currencies

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.vald3nir.btg_challenge.databinding.LayoutCurrencyItemBinding
import com.vald3nir.btg_challenge.items_view.CurrencyItemView

class CurrenciesAdapter(val listener: ICurrenciesAdapter) :
    RecyclerView.Adapter<CurrenciesAdapter.CurrencyViewHolder>() {

    var list: List<CurrencyItemView> = listOf()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val view = LayoutCurrencyItemBinding.inflate(
            LayoutInflater.from(parent.context), parent, false
        )
        return CurrencyViewHolder(view)
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        getItemId(position).let { holder.bind(list[position]) }
    }

    override fun getItemCount(): Int {
        return list.size
    }

    inner class CurrencyViewHolder(private val itemBinding: LayoutCurrencyItemBinding) :
        RecyclerView.ViewHolder(itemBinding.root) {

        fun bind(currencyItemView: CurrencyItemView) {
            itemBinding.itemView = currencyItemView
            itemBinding.listener = View.OnClickListener {
                listener.onClickCurrency(currencyItemView.code)
            }
        }
    }

    interface ICurrenciesAdapter {
        fun onClickCurrency(code: String?)
    }
}