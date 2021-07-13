package com.example.desafiobtg.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.desafiobtg.R
import com.example.desafiobtg.entity.CoinEntity

class CoinsAdapter(private val coins: ArrayList<CoinEntity>): RecyclerView.Adapter<RecyclerView.ViewHolder>() {


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val viewHolder: RecyclerView.ViewHolder?
        val view = LayoutInflater.from(parent.context).inflate(R.layout.coin_item, parent, false)
        viewHolder = CoinViewHolder(view)
        return viewHolder
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        (holder as CoinViewHolder).bindView(coins[position])
    }

    override fun getItemCount(): Int {
        return coins.size
    }

    class CoinViewHolder(itemView: View): RecyclerView.ViewHolder(itemView){
        fun bindView(coin: CoinEntity){

            val txtCod: TextView = itemView.findViewById(R.id.txt_cod_coin)
            val txtName: TextView = itemView.findViewById(R.id.txt_name_coin)

            txtCod.text = coin.cod
            txtName.text = coin.name
        }
    }
}