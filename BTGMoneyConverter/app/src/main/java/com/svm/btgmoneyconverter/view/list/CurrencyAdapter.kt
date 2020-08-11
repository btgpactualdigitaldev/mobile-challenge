package com.svm.btgmoneyconverter.view.list

import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.SortedList
import androidx.recyclerview.widget.SortedListAdapterCallback
import com.svm.btgmoneyconverter.R
import com.svm.btgmoneyconverter.model.Currency
import com.svm.btgmoneyconverter.viewmodel.ListVM
import java.util.*
import kotlin.collections.ArrayList

class CurrencyAdapter(private val list: ArrayList<Currency>, private val viewModel: ListVM) : RecyclerView.Adapter<CurrencyVH>() {

    private var sList: SortedList<Currency>

    init {
        sList = SortedList(Currency::class.java, object : SortedListAdapterCallback<Currency>(this) {
            override fun compare(o1: Currency, o2: Currency): Int = o1.symbol.compareTo(o2.symbol)

            override fun areContentsTheSame(oldItem: Currency, newItem: Currency): Boolean = oldItem.name == newItem.name

            override fun areItemsTheSame(item1: Currency, item2: Currency): Boolean = item1 == item2
        })
        sList.addAll(list)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyVH {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.currency_adapter, parent, false)
        return CurrencyVH(view)
    }

    override fun getItemCount(): Int = sList.size()

    override fun onBindViewHolder(holder: CurrencyVH, position: Int) {
        holder.setAdapterData(sList[position])
        holder.itemView.setOnClickListener{
            viewModel.onSelectCurrency(sList[position].symbol)
        }
    }

    fun searchElementOnList(text: String) {
        val textUc = text.toUpperCase()
        val filteredList = ArrayList<Currency>()
        list.forEach {
            val nameUc = it.name.toUpperCase()
            val symbolUc = it.symbol.toUpperCase()

            if (nameUc.contains(textUc) || symbolUc.contains(textUc))  filteredList.add(it)
        }

        sList.beginBatchedUpdates()
        sList.clear()
        sList.addAll(filteredList)
        sList.endBatchedUpdates()
    }

}
