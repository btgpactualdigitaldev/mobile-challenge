package br.com.albertomagalhaes.btgcurrencies.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.albertomagalhaes.btgcurrencies.R
import br.com.albertomagalhaes.btgcurrencies.dto.CurrencyDTO
import br.com.albertomagalhaes.btgcurrencies.getCurrencyImage
import kotlinx.android.synthetic.main.item_currency_conversion.view.*
import java.util.*

class CurrencyConversionAdapter(private val onClick: (CurrencyDTO) -> Unit) :
    RecyclerView.Adapter<CurrencyConversionAdapter.ViewHolder>() {

    private var list: MutableList<CurrencyDTO> = mutableListOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_currency_conversion, parent, false)

        return ViewHolder(
            view,
            onClick
        )
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bindView(list[position])
    }

    override fun getItemCount(): Int = list.size

    class ViewHolder(
        itemView: View,
        private val onClick: (currencyDTO: CurrencyDTO) -> Unit
    ) : RecyclerView.ViewHolder(itemView) {

        fun bindView(
            currencyDTO: CurrencyDTO
        ) {
            val drawable = itemView.context.getDrawable(R.drawable.currency_unknown)

            itemView.item_currency_conversion_iv_flag.setImageDrawable(
                getCurrencyImage(
                    itemView.context, currencyDTO.code.toLowerCase(
                        Locale.getDefault()
                    )
                ) ?: drawable
            )

            itemView.item_currency_conversion_tv_code.text = currencyDTO.code
            itemView.item_currency_conversion_tv_value.text = currencyDTO.convertedValue.toString()

            itemView.setOnClickListener {
                onClick.invoke(currencyDTO)
            }
        }
    }

    fun setList(list: MutableList<CurrencyDTO>) {
        this.list = list
        notifyDataSetChanged()
    }
}