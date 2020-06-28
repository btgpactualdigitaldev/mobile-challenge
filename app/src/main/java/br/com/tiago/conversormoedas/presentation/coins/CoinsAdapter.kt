package br.com.tiago.conversormoedas.presentation.coins

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.com.tiago.conversormoedas.R
import br.com.tiago.conversormoedas.data.model.Coin
import kotlinx.android.synthetic.main.item_coin.view.*

class CoinsAdapter(
    private val coins: List<Coin>,
    private val onItemClickListener: ((coin: Coin) -> Unit)
): RecyclerView.Adapter<CoinsAdapter.CoinsViewHolder>() {

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): CoinsViewHolder {
        val itemView = LayoutInflater.from(parent.context).inflate(R.layout.item_coin, parent, false)
        return CoinsViewHolder(itemView, onItemClickListener)
    }

    override fun getItemCount(): Int = coins.count()

    override fun onBindViewHolder(viewHolder: CoinsViewHolder, position: Int) {
        viewHolder.bindView(coins[position])
    }

    class CoinsViewHolder(
        itemView: View,
        private val onItemClickListener: ((coin: Coin) -> Unit)
    ) : RecyclerView.ViewHolder(itemView) {

        private val initials = itemView.txtInitials
        private val name = itemView.txtNameCoin

        fun bindView(coin: Coin){
            initials.text = coin.initials
            name.text = coin.name

            //itemclickListener
            itemView.setOnClickListener {
                onItemClickListener.invoke(coin)
            }
        }
    }
}