package com.example.coinconverter.presentation.viewholder

import androidx.recyclerview.widget.RecyclerView
import com.example.coinconverter.databinding.ItemListBinding
import com.example.coinconverter.domain.model.Currencie

class ItemListViewHolder(
    private val itemListBinding: ItemListBinding
): RecyclerView.ViewHolder(itemListBinding.root) {

    fun setItens(currencie: Currencie){
        itemListBinding.nameKey.text = currencie.key
        itemListBinding.nameValue.text = currencie.value
    }
}