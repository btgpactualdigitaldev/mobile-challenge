package br.com.leandrospidalieri.btgpactualconversion.ui.currencies

import androidx.annotation.LayoutRes
import androidx.recyclerview.widget.RecyclerView
import br.com.leandrospidalieri.btgpactualconversion.R
import br.com.leandrospidalieri.btgpactualconversion.databinding.CurrenciesItemBinding

class CurrenciesViewHolder(val viewBinding: CurrenciesItemBinding)
    : RecyclerView.ViewHolder(viewBinding.root){

    companion object {
        @LayoutRes
        val LAYOUT = R.layout.currencies_item
    }
}