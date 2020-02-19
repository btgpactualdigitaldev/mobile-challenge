package com.btgpactual.mobilechallenge.features.listcurrencies

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.btgpactual.domain.entity.Currency
import com.btgpactual.mobilechallenge.R
import com.btgpactual.mobilechallenge.databinding.RowCurrencyBinding

class CurrenciesAdapter : RecyclerView.Adapter<CurrenciesAdapter.ViewHolder>() {

    interface OnCurrencyClickListener{
        fun onCurrencyClick(currency: Currency)
    }

    private val currencies = mutableListOf<Currency>()
    var onCurrencyClickListener : OnCurrencyClickListener? = null

    fun setData(currencies : List<Currency>){
        this.currencies.clear()
        this.currencies.addAll(currencies)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding : RowCurrencyBinding = DataBindingUtil.inflate(inflater, R.layout.row_currency,parent,false)
        return ViewHolder(binding)
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(currencies[position])
    }


    inner class ViewHolder(private val binding: RowCurrencyBinding) : RecyclerView.ViewHolder(binding.root) {

        @SuppressLint("SetTextI18n")
        fun bind(currency : Currency){
            binding.root.setOnClickListener {
                onCurrencyClickListener?.onCurrencyClick(currency)
            }
            binding.currencyTextView.text = "${currency.code} - ${currency.name}"
        }
    }


}