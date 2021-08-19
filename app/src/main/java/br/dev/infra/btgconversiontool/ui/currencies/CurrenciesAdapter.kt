package br.dev.infra.btgconversiontool.ui.currencies

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import br.dev.infra.btgconversiontool.data.CurrencyView
import br.dev.infra.btgconversiontool.databinding.GridCurrenciesBinding
import java.text.NumberFormat
import java.util.*

class CurrenciesAdapter(
    private val dataset: List<CurrencyView>
) : RecyclerView.Adapter<CurrenciesAdapter.CurrenciesViewHolder>() {

    class CurrenciesViewHolder(val binding: GridCurrenciesBinding) :
        RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CurrenciesViewHolder {
        val binding =
            GridCurrenciesBinding.inflate(LayoutInflater.from(parent.context), parent, false)

        return CurrenciesViewHolder(binding)
    }

    override fun onBindViewHolder(holder: CurrenciesViewHolder, position: Int) {
        with(holder) {
            val item = dataset[position]

            val currFormat = NumberFormat.getCurrencyInstance(Locale.getDefault())
            currFormat.currency = Currency.getInstance(item.id)


            binding.currencyId.text = item.id
            binding.currencyDetails.text = item.description
            binding.currencyQuote.text = currFormat.format(item.quote)
        }
    }

    override fun getItemCount(): Int {
        return dataset.size
    }
}