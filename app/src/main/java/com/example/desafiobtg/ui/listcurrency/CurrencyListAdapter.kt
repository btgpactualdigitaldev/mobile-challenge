package com.example.desafiobtg.ui.listcurrency

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.desafiobtg.databinding.ItemCurrencyListBinding

class CurrencyListAdapter(
        private val currencyFullName: Collection<String>?,
        private val currencyCode: Set<String>?
) : RecyclerView.Adapter<CurrencyListAdapter.ViewHolder>() {

    inner class ViewHolder( val binding: ItemCurrencyListBinding) : RecyclerView.ViewHolder(binding.root){

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding = ItemCurrencyListBinding.inflate(
                LayoutInflater.from(parent.context),parent,false
        )
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        with(holder){
            val fullName = currencyFullName?.elementAt(position)
            val code = currencyCode?.elementAt(position)
            binding.fullCurrencyName.text = fullName
            binding.currencyCodeValue.text = code
        }
    }

    override fun getItemCount() = currencyCode?.size ?: 0
}