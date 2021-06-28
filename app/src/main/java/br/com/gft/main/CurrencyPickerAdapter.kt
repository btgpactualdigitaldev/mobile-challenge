package br.com.gft.main

import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.recyclerview.widget.RecyclerView
import br.com.gft.R
import br.com.gft.main.iteractor.model.Currency
import kotlinx.android.synthetic.main.currency_pick_item.view.*
import java.util.*
import kotlin.collections.ArrayList

class CurrencyPickerAdapter(
    private val onItemClicked: (Currency) -> Unit, private var currencyList: List<Currency>
) :
    RecyclerView.Adapter<CurrencyPickerAdapter.ViewHolder>(), Filterable {

    var currencyFilterList : List<Currency>

    init {
        currencyFilterList = currencyList
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view =
            LayoutInflater.from(parent.context).inflate(R.layout.currency_pick_item, parent, false)
        return ViewHolder(view as ConstraintLayout)
    }

    override fun getItemCount() = currencyFilterList.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.view.apply {
            currency.text = resources.getString(R.string.currency_item_name,currencyFilterList[position].code,currencyFilterList[position].name)
            currency.setOnClickListener { onItemClicked(currencyFilterList[position]) }
        }
    }

    class ViewHolder(val view: ConstraintLayout) : RecyclerView.ViewHolder(view)

    override fun getFilter(): Filter {
        return object : Filter() {
            override fun performFiltering(constraint: CharSequence?): FilterResults {
                val charSearch = constraint.toString()
                if (charSearch.isEmpty()) {
                    currencyFilterList = currencyList
                } else {
                    val resultList = ArrayList<Currency>()
                    for (row in currencyList) {
                        val searchText = row.code+row.name
                        if (searchText.toLowerCase(Locale.ROOT).contains(charSearch.toLowerCase(Locale.ROOT))) {
                            resultList.add(row)
                        }
                    }
                    currencyFilterList = resultList
                }
                val filterResults = FilterResults()
                filterResults.values = currencyFilterList
                return filterResults
            }

            @Suppress("UNCHECKED_CAST")
            override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
                currencyFilterList = results?.values as List<Currency>
                notifyDataSetChanged()
            }

        }
    }

    fun sortByName() {
        currencyFilterList =  currencyFilterList.sortedBy { it.name }
        notifyDataSetChanged()
    }

    fun sortByCode() {
        currencyFilterList = currencyFilterList.sortedBy { it.code }
        notifyDataSetChanged()
    }
}