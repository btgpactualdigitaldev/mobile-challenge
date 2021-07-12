package com.example.currencies.ui

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.currencies.R
import com.example.currencies.listener.EventListener
import com.example.currencies.model.room.CurrenciesModelLocal

class ConverterAdapter  : RecyclerView.Adapter<ConverterViewHolder>() {

    private var mList: List<CurrenciesModelLocal> = arrayListOf()
    private lateinit var mListener: EventListener

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ConverterViewHolder {
        val item = LayoutInflater.from(parent.context).inflate(R.layout.row_currencies, parent, false)
        return ConverterViewHolder(item, mListener)
    }

    override fun getItemCount(): Int {
        return mList.count()
    }

    override fun onBindViewHolder(holder: ConverterViewHolder, position: Int) {
        holder.bindData(mList[position])
    }

    fun attachListener(listener: EventListener) {
        mListener = listener
    }

    fun updateList(list: List<CurrenciesModelLocal>){
        mList = list
        notifyDataSetChanged()
    }
}


