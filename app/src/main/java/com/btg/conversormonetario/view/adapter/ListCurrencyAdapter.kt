package com.btg.conversormonetario.view.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.widget.AppCompatImageView
import androidx.appcompat.widget.AppCompatTextView
import androidx.cardview.widget.CardView
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.RecyclerView
import com.btg.conversormonetario.R
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import com.btg.conversormonetario.view.viewmodel.ChooseCurrencyViewModel
import kotlinx.android.synthetic.main.item_currency.view.*

open class ListCurrencyAdapter(
    var context: Context,
    var viewModel: ChooseCurrencyViewModel,
    var currencies: ArrayList<InfoCurrencyModel.DTO>
) : RecyclerView.Adapter<ListCurrencyAdapter.ListCurrencyViewHolder>() {

    var positionCurrencyChoosed: (InfoCurrencyModel.DTO) -> Unit = { }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ListCurrencyViewHolder {
        return ListCurrencyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_currency,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return currencies.size
    }

    override fun onBindViewHolder(holder: ListCurrencyViewHolder, position: Int) {
        with(holder) {
            tvwCode.text = currencies[position].code
            tvwName.text = currencies[position].name
            imvIcon.setImageDrawable(ContextCompat.getDrawable(context,
                viewModel.getCurrencyIconByCode(currencies[position].code ?: "")
                    ?: R.drawable.ic_default_currency
            )
            )
        }
    }

    fun updateListwithFilteredValues(filteredList: ArrayList<InfoCurrencyModel.DTO>) {
        currencies = filteredList
        notifyDataSetChanged()
    }

    inner class ListCurrencyViewHolder(v: View) : RecyclerView.ViewHolder(v) {
        val card: CardView = v.cdvItemChooseCurrency
        val tvwCode: AppCompatTextView = v.tvwItemChooseCurrencyCode
        val tvwName: AppCompatTextView = v.tvwItemChooseCurrencyName
        val imvIcon: AppCompatImageView = v.imvItemChooseCurrencyIcon

        init {
            card.setOnClickListener {
                positionCurrencyChoosed.invoke(currencies[adapterPosition])
            }
        }
    }
}