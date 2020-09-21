package br.com.leandrospidalieri.btgpactualconversion.ui.currencies

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat.getDrawable
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import br.com.leandrospidalieri.btgpactualconversion.R
import br.com.leandrospidalieri.btgpactualconversion.databinding.FragmentCurrenciesBinding
import br.com.leandrospidalieri.btgpactualconversion.viewmodel.ConverterViewModel
import kotlinx.android.synthetic.main.fragment_currencies.view.*

class CurrenciesFragment : Fragment() {
    private val viewModel: ConverterViewModel by lazy{
        ViewModelProvider(requireActivity()).get(ConverterViewModel::class.java)
    }

    private var currenciesAdapter: CurrenciesAdapter? = null

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        viewModel.currencyList.observe(viewLifecycleOwner,Observer{
                currencyList->
            currencyList?.apply {
                currenciesAdapter?.currencies = currencyList
            }
        })

        viewModel.selectedCurrencies.observe(viewLifecycleOwner, Observer { selectedCurrencies ->
            if(selectedCurrencies != null && selectedCurrencies.size == 2){
                this.findNavController().navigateUp()
            }
        })
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val binding = FragmentCurrenciesBinding.inflate(inflater)
        binding.lifecycleOwner = this
        binding.viewModel = viewModel

        currenciesAdapter =
            CurrenciesAdapter(CurrencyListener {
                viewModel.addCurrencies(it)
            })

        binding.root.currency_list.apply {
            val divider = DividerItemDecoration(this.context, DividerItemDecoration.VERTICAL)
            divider.setDrawable(getDrawable(context,R.drawable.divider)!!)
            addItemDecoration(divider)
            layoutManager = LinearLayoutManager(context)
            adapter = currenciesAdapter
        }
        return binding.root
    }
}