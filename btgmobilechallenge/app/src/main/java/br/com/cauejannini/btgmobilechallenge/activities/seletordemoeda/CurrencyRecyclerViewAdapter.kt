package br.com.cauejannini.btgmobilechallenge.activities.seletordemoeda

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.SortedList
import androidx.recyclerview.widget.SortedListAdapterCallback
import br.com.cauejannini.btgmobilechallenge.R
import br.com.cauejannini.btgmobilechallenge.commons.Currency

class CurrencyRecyclerViewAdapter(private val currencyList: List<Currency>, private val mListener: OnCurrencySelectedListener) :
    RecyclerView.Adapter<CurrencyRecyclerViewAdapter.CurrencyViewHolder>() {

    private val sortedCurrencyList: SortedList<Currency>

    init {

        sortedCurrencyList = SortedList(Currency::class.java, object: SortedListAdapterCallback<Currency>(this) {

            override fun areItemsTheSame(item1: Currency?, item2: Currency?): Boolean = item1 == item2

            override fun compare(o1: Currency?, o2: Currency?): Int {
                if (o1 == null) return -1
                if (o2 == null) return 1

                return o1.symbol.compareTo(o2.symbol)
            }

            override fun areContentsTheSame(oldItem: Currency?, newItem: Currency?): Boolean {
                if (oldItem == null && newItem == null) return true
                if (oldItem != null && newItem != null)
                    return oldItem.symbol == newItem.symbol

                return false
            }

        })

        sortedCurrencyList.addAll(currencyList)
    }

    class CurrencyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        val tvSymbol: TextView = itemView.findViewById(R.id.tvSymbol)
        val tvName: TextView = itemView.findViewById(R.id.tvName)

        fun setCurrency(currency: Currency) {
            tvSymbol.text = currency.symbol
            tvName.text = currency.name
        }

    }

    fun filtrarLista(text: String) {
        val lowerCase = text.toLowerCase()

        val filteredList = ArrayList<Currency>()
        for (currency in currencyList) {
            val symbolLower = currency.symbol.toLowerCase()
            val nameLower = currency.name.toLowerCase()

            if (symbolLower.contains(lowerCase) || nameLower.contains(lowerCase)) {
                filteredList.add(currency)
            }
        }

        sortedCurrencyList.beginBatchedUpdates()
        sortedCurrencyList.clear()
        sortedCurrencyList.addAll(filteredList)
        sortedCurrencyList.endBatchedUpdates()

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_currency, parent, false)
        return CurrencyViewHolder(view)
    }

    override fun getItemCount(): Int {
        return sortedCurrencyList.size()
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {

        val currency = sortedCurrencyList.get(position)
        holder.setCurrency(currency)

        holder.itemView.setOnClickListener {
            mListener.onCurrencySelected(currency.symbol)
        }
    }

    interface OnCurrencySelectedListener {
        fun onCurrencySelected(currencySymbol: String)
    }
}