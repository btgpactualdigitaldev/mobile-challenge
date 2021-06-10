package clcmo.com.btgcurrency.view.holder

import androidx.recyclerview.widget.DiffUtil
import clcmo.com.btgcurrency.view.model.CurrencyUI

class CAdapterDiffUtilItemCallback : DiffUtil.ItemCallback<CurrencyUI>() {

    override fun areContentsTheSame(oldItem: CurrencyUI, newItem: CurrencyUI) = oldItem == newItem

    override fun areItemsTheSame(oldItem: CurrencyUI, newItem: CurrencyUI) = oldItem.id == newItem.id
}