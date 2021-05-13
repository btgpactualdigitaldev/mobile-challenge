package com.btg.convertercurrency.features.currency_list.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.btg.convertercurrency.R
import com.btg.convertercurrency.databinding.ListCurrencyFragmentBinding
import com.btg.convertercurrency.databinding.ListCurrencyItemBinding
import com.btg.convertercurrency.databinding.PopupCurrencySelectItemBinding
import com.btg.convertercurrency.features.base_entity.CurrencyItem
import com.btg.convertercurrency.features.util.RecyclerViewBinding

class ListCurrencyAdapter(
    private val clickActionListItem: ((currencyItem: CurrencyItem) -> Unit) = {}
) : RecyclerView.Adapter<ListCurrencyAdapter.CurrencyListItemViewHolder>(),
    RecyclerViewBinding.BindableAdapter<List<CurrencyItem>> {

    private val itemList = mutableListOf<CurrencyItem>()
    private var filterItemList = mutableListOf<CurrencyItem>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrencyListItemViewHolder =
        CurrencyListItemViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.list_currency_item,
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

    override fun onBindViewHolder(holder: CurrencyListItemViewHolder, position: Int) {

        holder.binding?.apply {

            itemList[position].let { currentItem_ ->

                //Atualiza a variavel da view(xml)
                currencyItem = currentItem_
                executePendingBindings()
                root.setOnClickListener {
                    clickActionListItem(currentItem_)
                }
            }
        }
    }

    inner class CurrencyListItemViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val binding = DataBindingUtil.bind<ListCurrencyItemBinding>(itemView)
    }
}