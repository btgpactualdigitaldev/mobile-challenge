package br.com.btg.btgchallenge.ui.fragments.currencylist

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.recyclerview.widget.RecyclerView
import br.com.btg.btgchallenge.R
import br.com.btg.btgchallenge.ui.fragments.conversions.Currency
import br.com.btg.btgchallenge.ui.fragments.conversions.CurrencyClicked
import br.com.btg.btgchallenge.ui.fragments.conversions.CurrencyType
import br.com.btg.btgchallenge.ui.fragments.extensions.inflate
import br.com.btg.btgchallenge.ui.fragments.extensions.listen
import kotlinx.android.synthetic.main.currency_item.view.*
import java.util.*
import kotlin.collections.HashMap


class CurrencyAdapter(private val currencies: Map<String, String>, val context: Context, val currencyType:CurrencyType, val event: (Currency) -> Unit): RecyclerView.Adapter<CurrencyAdapter.CurrencyHolder>(),
    Filterable {

    lateinit var filteredCurencies : Map<String, String>
    init {
        filteredCurencies = currencies
    }
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyHolder {
        val inflatedView = parent.inflate(R.layout.currency_item, false)
        return CurrencyHolder(inflatedView, context).listen{pos, type ->
            val item = filteredCurencies.toList().get(pos)
            event.invoke(Currency(item, currencyType))
        }
    }

    override fun getItemCount(): Int = filteredCurencies.size

    override fun onBindViewHolder(holder: CurrencyHolder, position: Int) {
        val itemCurrency = filteredCurencies.toList().get(position)
        holder.bindName(itemCurrency, context)
    }

    class CurrencyHolder(private val view: View, context: Context) : RecyclerView.ViewHolder(view) {
        private var currency: Pair<String, String>? = null


        fun bindName(currency: Pair<String, String>, context: Context) {
            this.currency = currency
            view.currency_name.text = currency.first
            view.currency_country.text = currency.second
            val uri = "@drawable/flag_"+currency.first.toString().toLowerCase()
            var imageResource: Int = context.resources.getIdentifier(uri, null, context.getPackageName())
            if(imageResource == 0)
            {
                imageResource = R.drawable.globe
            }
            view.currency_country_image.setImageResource(imageResource)
        }
    }

    override fun getFilter(): Filter {
        return object : Filter()
        {
            override fun performFiltering(constraint: CharSequence?): FilterResults {
               if(constraint == null || constraint.length == 0)
               {
                   filteredCurencies = currencies
               }
                else
               {
                   filteredCurencies = currencies.filterValues { it.toLowerCase().contains(constraint.toString().toLowerCase()) }
               }
                val filterResults = FilterResults()
                filterResults.values = filteredCurencies
                return filterResults
            }

            override fun publishResults(constraint: CharSequence?, results: FilterResults?) {
                filteredCurencies = results?.values as Map<String, String>
                notifyDataSetChanged()
            }
        }
    }


}