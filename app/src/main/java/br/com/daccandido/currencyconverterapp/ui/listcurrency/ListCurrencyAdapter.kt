package br.com.daccandido.currencyconverterapp.ui.listcurrency

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.model.Currency
import io.realm.OrderedRealmCollection
import io.realm.RealmRecyclerViewAdapter
import kotlinx.android.synthetic.main.item_list_currencies.view.*

class ListCurrencyAdapter(private val context: Context, private val auto: Boolean,
                          private val click: ClickItemList,
                          private var currencies: OrderedRealmCollection<Currency>)

    : RealmRecyclerViewAdapter<Currency, ListCurrencyAdapter.ViewHolder>(currencies, auto) {

    constructor(currencies: OrderedRealmCollection<Currency>, context: Context, click: ClickItemList)
            : this(context, true, click, currencies)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.item_list_currencies, parent, false)
        return ViewHolder(view)
    }

    override fun getItemId(index: Int): Long {
        return getItem(index)?.id ?: 0
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bindView(currencies[position], click)
    }

    fun setList(newList: OrderedRealmCollection<Currency>) {
        currencies = newList
        notifyDataSetChanged()
    }

    fun sortList (field: String) {
        currencies = currencies.sort(field)
        notifyDataSetChanged()
    }

    class ViewHolder (itemView: View): RecyclerView.ViewHolder(itemView), View.OnClickListener {

        lateinit var currency: Currency
        lateinit var clickItemList: ClickItemList

        fun bindView (_currency: Currency, click: ClickItemList) {
            currency = _currency
            clickItemList = click
            itemView.tvName.text = currency.name
            itemView.tvCode.text = currency.code
            itemView.setOnClickListener(this)
        }

        override fun onClick(view: View?) {
            clickItemList.onClick(currency)
        }

    }
}