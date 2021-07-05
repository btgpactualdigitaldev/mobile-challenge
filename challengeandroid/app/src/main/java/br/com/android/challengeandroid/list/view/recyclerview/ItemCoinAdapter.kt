package br.com.android.challengeandroid.list.view.recyclerview

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.android.challengeandroid.R
import br.com.android.challengeandroid.model.CoinList

class ItemCoinAdapter(private val itemCoinClickListener: ItemCoinClickListener) :
    RecyclerView.Adapter<ItemCoinViewHolder>() {

    private val list = mutableListOf<CoinList>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemCoinViewHolder {
        val inflater =
            LayoutInflater.from(parent.context).inflate(R.layout.item_coin, parent, false)
        return ItemCoinViewHolder(inflater, itemCoinClickListener)
    }

    override fun getItemCount(): Int {
        return list.size
    }

    override fun onBindViewHolder(holder: ItemCoinViewHolder, position: Int) {
        holder.bind(list[position])
    }

    fun setList(list: List<CoinList>, currenciesAccepted: List<String>) {
        this.list.clear()
        if (currenciesAccepted.isNotEmpty()) {
            this.list.addAll(list.filter { currenciesAccepted.contains(it.code) })
        } else {
            this.list.addAll(list)
        }

    }
}