package com.btg.convertercurrency.features.util.poupup_currency_select

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.btg.convertercurrency.R
import com.btg.convertercurrency.databinding.PopupCurrencySelectItemBinding
import com.btg.convertercurrency.features.base_entity.CurrencyItem
import com.btg.convertercurrency.features.util.RecyclerViewBinding
import com.btg.convertercurrency.features.util.RecyclerViewTextFilterItemBinding

class CustomPopupCurrencySelectAdapter(
    private val clickActionListItem: ((currencyItem: CurrencyItem) -> Unit) = {}
) : RecyclerView.Adapter<CustomPopupCurrencySelectAdapter.CurrencyItemViewHolder>(),
    RecyclerViewBinding.BindableAdapter<List<CurrencyItem>>,
    RecyclerViewTextFilterItemBinding.BindableTextFilterAdapter {

    private val itemList = mutableListOf<CurrencyItem>()
    private var filterItemList = mutableListOf<CurrencyItem>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyItemViewHolder =
        CurrencyItemViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.popup_currency_select_item,
                parent,
                false
            )
        )

    override fun setData(data: List<CurrencyItem>?) {
        itemList.clear()
        itemList.addAll(data ?: listOf())
        notifyDataSetChanged()
    }

    override fun getItemCount() = itemList.size

    override fun onBindViewHolder(holder: CurrencyItemViewHolder, position: Int) {

        holder.binding?.apply {

            itemList[position].let { currentItem ->

                //Atualiza a variavel da view(xml)
                currencyItem = currentItem
                executePendingBindings()
                root.setOnClickListener {
                    clickActionListItem(currentItem)
                }
            }
        }
    }

    inner class CurrencyItemViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val binding = DataBindingUtil.bind<PopupCurrencySelectItemBinding>(itemView)
    }

    override fun setFilterText(text: String) {

        if (filterItemList.isEmpty())
            filterItemList = itemList.toMutableList()

        itemList.clear()

        filterItemList.forEach {
            it.filter = text
            if (it. titleContains(text))
                itemList.add(it)
        }

        if (text.isEmpty()) {
            filterItemList.clear()
        }

        notifyDataSetChanged()
    }
}