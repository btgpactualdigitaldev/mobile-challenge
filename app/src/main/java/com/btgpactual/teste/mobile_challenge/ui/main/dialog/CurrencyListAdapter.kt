package com.btgpactual.teste.mobile_challenge.ui.main.dialog

import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.recyclerview.widget.RecyclerView
import com.btgpactual.teste.mobile_challenge.R
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity
import com.btgpactual.teste.mobile_challenge.ui.main.ISelectedCurrency
import com.btgpactual.teste.mobile_challenge.ui.main.TypeCurrency
import kotlin.collections.ArrayList


/**
 * Created by Carlos Souza on 17,October,2020
 */
class CurrencyListAdapter(var originCurrencyList: MutableList<CurrencyEntity>, onItemSelected: ISelectedCurrency, type: TypeCurrency): RecyclerView.Adapter<CurrencyViewHolder>(), Filterable {

    var helpCurrencyList = mutableListOf<CurrencyEntity>()

    private val onSelected: ISelectedCurrency = onItemSelected

    private val typeCurrency = type

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        return CurrencyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.dialog_list_currency_item,
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        val currencyEntity = helpCurrencyList[position]
        holder.codCurrency.text = currencyEntity.id
        holder.descCurrency.text = currencyEntity.desc
        holder.itemCurrency.setOnClickListener {
            Log.d("Adapter", "onBindViewHolder: ${currencyEntity.id}")
            onSelected.onSelectedCurrency(currencyEntity.id, typeCurrency)
        }
    }

    override fun getItemCount(): Int {
        return helpCurrencyList.size
    }

    override fun getFilter(): Filter {
        return currencyFilter
    }

    private val currencyFilter: Filter = object : Filter() {
        override fun performFiltering(constraint: CharSequence): FilterResults {
            var filteredList: MutableList<CurrencyEntity> = ArrayList()
            if (constraint.isEmpty()) {
                filteredList.addAll(originCurrencyList)
            } else {
                val filterPattern = constraint.toString().toLowerCase().trim { it <= ' ' }
                filteredList = originCurrencyList.filter {
                    it.id.toLowerCase().contains(filterPattern) || it.desc.toLowerCase().contains(filterPattern)
                } as MutableList<CurrencyEntity>
            }
            val results = FilterResults()
            results.values = filteredList
            return results
        }

        override fun publishResults(constraint: CharSequence, results: FilterResults) {
            helpCurrencyList.clear()
            helpCurrencyList.addAll(results.values as MutableList<CurrencyEntity>)
            notifyDataSetChanged()
        }
    }

    init {
        helpCurrencyList.addAll(originCurrencyList)
    }
}
