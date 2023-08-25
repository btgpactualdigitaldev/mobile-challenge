package br.com.btg.mobile.challenge.ui.currency.list

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import br.com.arch.toolkit.delegate.viewProvider
import br.com.btg.mobile.challenge.R
import br.com.btg.mobile.challenge.data.model.Price
import br.com.btg.mobile.challenge.extension.orZero

class CurrencyListAdapter(private val callbackClick: (Price) -> Unit) :
    RecyclerView.Adapter<CurrencyListAdapter.ViewHolder>() {

    private var dataSet: List<Price> = mutableListOf()

    class ViewHolder(private val view: View) : RecyclerView.ViewHolder(view) {

        private val textViewFirst: TextView by viewProvider(R.id.textViewFirst)
        private val textViewSecond: TextView by viewProvider(R.id.textViewSecond)

        fun bindView(item: Price, callbackClick: (Price) -> Unit) {
            textViewFirst.apply { text = item.coin }
            textViewSecond.apply { text = item.price.orZero().toString() }
            view.setOnClickListener { callbackClick(item) }
        }
    }

    override fun onCreateViewHolder(viewGroup: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(viewGroup.context)
            .inflate(R.layout.item_currency, viewGroup, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(viewHolder: ViewHolder, position: Int) {
        viewHolder.bindView(dataSet[position], callbackClick)
    }

    override fun getItemCount() = dataSet.size

    @SuppressLint("NotifyDataSetChanged")
    fun data(dataSet: List<Price>) {
        this@CurrencyListAdapter.dataSet = dataSet
        notifyDataSetChanged()
    }
}
