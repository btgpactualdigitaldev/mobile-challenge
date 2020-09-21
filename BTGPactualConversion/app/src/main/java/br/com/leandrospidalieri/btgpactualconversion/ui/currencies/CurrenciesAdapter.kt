package br.com.leandrospidalieri.btgpactualconversion.ui.currencies

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import br.com.leandrospidalieri.btgpactualconversion.databinding.CurrenciesItemBinding
import br.com.leandrospidalieri.btgpactualconversion.domain.models.Currency

class CurrenciesAdapter(val clickListener: CurrencyListener)
    : RecyclerView.Adapter<CurrenciesViewHolder>(){

    var currencies: List<Currency> = emptyList()

        set(value){
            field = value
            notifyDataSetChanged()
        }
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrenciesViewHolder {
        val withDataBinding: CurrenciesItemBinding = DataBindingUtil.inflate(
            LayoutInflater.from(parent.context),
            CurrenciesViewHolder.LAYOUT,
            parent,
            false
        )
        return CurrenciesViewHolder(withDataBinding)
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    override fun onBindViewHolder(holder: CurrenciesViewHolder, position: Int) {
        holder.viewBinding.also{
            it.currency = currencies[position]
            it.clickListener = clickListener
        }
    }
}

class CurrencyListener(val clickListener: (currency: Currency) -> Unit){
    fun onClick(currency:Currency) = clickListener(currency)
}