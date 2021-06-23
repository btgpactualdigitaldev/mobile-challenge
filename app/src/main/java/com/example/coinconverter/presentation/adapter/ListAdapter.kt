package com.example.coinconverter.presentation.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.coinconverter.databinding.ItemListBinding
import com.example.coinconverter.domain.model.Currencie
import com.example.coinconverter.presentation.viewholder.ItemListViewHolder

class ListAdapter(): RecyclerView.Adapter<ItemListViewHolder>() {

    private lateinit var itemListBinding: ItemListBinding
    var listCurrencie: List<Currencie> = emptyList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemListViewHolder {

        itemListBinding = ItemListBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ItemListViewHolder(itemListBinding);
    }

    override fun onBindViewHolder(holder: ItemListViewHolder, position: Int) {
         holder.setItens(listCurrencie[position])
    }

    override fun getItemCount(): Int {
        return listCurrencie.size
    }

    fun setData(list: List<Currencie>){
        listCurrencie = list
        notifyDataSetChanged()
    }
}