package br.com.albertomagalhaes.btgcurrencies.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.albertomagalhaes.btgcurrencies.R
import br.com.albertomagalhaes.btgcurrencies.dto.CurrencyDTO
import br.com.albertomagalhaes.btgcurrencies.getCurrencyImage
import kotlinx.android.synthetic.main.item_currency_selection.view.*
import java.util.*

class CurrencySelectionAdapter(private val onItemClickListener: (currencyDTO: CurrencyDTO) -> Unit
) : RecyclerView.Adapter<CurrencySelectionAdapter.ViewHolder>() {

    private var list: List<CurrencyDTO> = listOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_currency_selection, parent, false)

        return ViewHolder(
            view,
            onItemClickListener
        )
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bindView(list[position])
    }

    override fun getItemCount(): Int = list.size

    class ViewHolder(
        itemView: View,
        private val onItemClickListener: (currencyDTO: CurrencyDTO) -> Unit
    ) : RecyclerView.ViewHolder(itemView) {

        fun bindView(currencyDTO: CurrencyDTO) {
            val drawable = itemView.context.getDrawable(R.drawable.currency_unknown)

            itemView.item_currency_selection_iv_flag.setImageDrawable(
                getCurrencyImage(
                    itemView.context, currencyDTO.code.toLowerCase(
                        Locale.getDefault()
                    )
                ) ?: drawable
            )

            itemView.item_currency_selection_tv_code.text = currencyDTO.code
            itemView.item_currency_selection_tv_name.text = currencyDTO.name
            if (currencyDTO.isSelected) {
                itemView.setBackgroundColor(itemView.context.getColor(R.color.primary_lightest))
            } else {
                itemView.setBackgroundColor(itemView.context.getColor(R.color.white))
            }
            itemView.setOnClickListener {
                onItemClickListener.invoke(currencyDTO)
            }
        }
    }

    fun setList(list: List<CurrencyDTO>){
        this.list = list
        notifyDataSetChanged()
    }

}