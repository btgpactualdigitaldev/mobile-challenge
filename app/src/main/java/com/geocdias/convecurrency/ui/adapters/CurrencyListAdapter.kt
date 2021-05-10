package com.geocdias.convecurrency.ui.adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Filter
import android.widget.Filterable
import androidx.recyclerview.widget.AsyncListDiffer
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.geocdias.convecurrency.databinding.CurrencyListItemBinding
import com.geocdias.convecurrency.model.CurrencyModel

class CurrencyListAdapter : RecyclerView.Adapter<CurrencyListAdapter.CurrencyViewHolder>(),
    Filterable {

    private lateinit var filteredList: List<CurrencyModel>

    private var originalList: List<CurrencyModel> = listOf()

    class CurrencyViewHolder(val binding: CurrencyListItemBinding) :
        RecyclerView.ViewHolder(binding.root)

    var diffCallback = object : DiffUtil.ItemCallback<CurrencyModel>() {
        override fun areItemsTheSame(oldItem: CurrencyModel, newItem: CurrencyModel): Boolean {
            return oldItem.code == newItem.code
        }

        override fun areContentsTheSame(oldItem: CurrencyModel, newItem: CurrencyModel): Boolean {
            return oldItem.hashCode() == newItem.hashCode()
        }
    }

    val differ: AsyncListDiffer<CurrencyModel> = AsyncListDiffer(this, diffCallback)

    var currencyList: List<CurrencyModel>
        get() = differ.currentList
        set(list) {
            if (originalList.isNullOrEmpty()) {
                originalList = list
            }
            differ.submitList(list)
        }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyViewHolder {
        return CurrencyViewHolder(
            CurrencyListItemBinding.inflate(
                LayoutInflater.from(parent.context),
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: CurrencyViewHolder, position: Int) {
        val currency = currencyList[position]
        holder.binding.currencyCode.text = currency.code
        holder.binding.currencyName.text = currency.name
        holder.binding.currencyItem.setOnClickListener {
            onItemClickListener?.let { onClick ->
                onClick(currency)
            }
        }
    }

    override fun getItemCount(): Int = currencyList.count()

    override fun getFilter(): Filter {
        return object : Filter() {
            override fun performFiltering(charSequence: CharSequence?): FilterResults {
                val stringValue = charSequence.toString()

                    filteredList = if (stringValue.isEmpty()) {
                        originalList
                    } else {
                        originalList.filter { currency ->
                            currency.code.toLowerCase().contains(stringValue) ||
                            currency.name.toLowerCase().contains(stringValue)
                        }
                    }

                return FilterResults().also {
                    it.values = filteredList
                }
            }

            override fun publishResults(charSequence: CharSequence?, result: FilterResults?) {
                currencyList = result?.values as List<CurrencyModel>
            }
        }
    }

    protected var onItemClickListener: ((CurrencyModel) -> Unit)? =  null

    fun setOnClickListener(listener: (CurrencyModel) -> Unit) {
        onItemClickListener = listener
    }
}
