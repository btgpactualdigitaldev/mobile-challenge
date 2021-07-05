package br.com.android.challengeandroid.list.view.recyclerview

import android.view.View
import android.widget.Button
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import br.com.android.challengeandroid.R
import br.com.android.challengeandroid.model.CoinList
import org.w3c.dom.Text

class ItemCoinViewHolder(itemView: View, private val itemCoinClickListener: ItemCoinClickListener) :
    RecyclerView.ViewHolder(itemView) {
    private var tvName: TextView = itemView.findViewById(R.id.tv_name)
    private var tvCode: TextView = itemView.findViewById(R.id.tv_code)
    private val btnToConvert: Button = itemView.findViewById(R.id.btn_to_convert)

    fun bind(coinList: CoinList) {
        tvName.text = coinList.name
        tvCode.text = coinList.code
        btnToConvert.setOnClickListener {
            itemCoinClickListener.let {
                itemCoinClickListener.clickItem(coinList.code)
            }
        }
    }
}