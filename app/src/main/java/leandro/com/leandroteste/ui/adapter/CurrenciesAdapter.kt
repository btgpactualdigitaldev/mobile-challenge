package leandro.com.leandroteste.ui.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import leandro.com.leandroteste.databinding.CurrencyItemBinding
import leandro.com.leandroteste.model.data.Currency

class CurrenciesAdapter(var items:List<Currency>):RecyclerView.Adapter<CurrenciesAdapter.ViewHolder>(),
    AdapterItemsContract {
    var onItemClick: ((Currency) -> Unit)? = null
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding: CurrencyItemBinding = CurrencyItemBinding.inflate(inflater,parent,false)
        return ViewHolder(binding)
    }

    override fun getItemCount(): Int {
        return items.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(items[position])
    }

    override fun replaceItems(items: List<*>) {
        this.items = items as List<Currency>
        notifyDataSetChanged()
    }

    inner class ViewHolder(val binding: CurrencyItemBinding): RecyclerView.ViewHolder(binding.root){
        fun bind(currency: Currency){
            binding.currency = currency
            binding.executePendingBindings()
        }

        init {
            itemView.setOnClickListener {
                onItemClick?.invoke(items[adapterPosition])
            }
        }
    }
}