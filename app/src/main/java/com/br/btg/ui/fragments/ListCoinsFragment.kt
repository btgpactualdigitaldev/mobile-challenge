package com.br.btg.ui.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

import androidx.lifecycle.Observer
import com.br.btg.data.models.Currency
import com.br.btg.data.models.CurrencyLayerModel
import com.br.btg.databinding.FragmentListCoinsBinding
import com.br.btg.ui.adapters.ListCoinsAdapter
import com.br.btg.ui.viewmodels.ConversorViewModel
import com.br.btg.utils.*
import org.koin.android.viewmodel.ext.android.sharedViewModel

class ListCoinsFragment() : Fragment() {


    private val adapter by lazy { ListCoinsAdapter(context = context!!) }

    private val viewModel: ConversorViewModel by sharedViewModel<ConversorViewModel>()

    private lateinit var fragmentListCoinsBinding: FragmentListCoinsBinding

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        fragmentListCoinsBinding = FragmentListCoinsBinding.inflate(inflater, container, false)
        return fragmentListCoinsBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        configureRecyclerView()
    }

    private fun configureRecyclerView() {
        fragmentListCoinsBinding.recyclerviewListCoins.adapter = adapter
        configureAdapter()
        getAllCurrencies()
    }

    private fun configureAdapter() {
        adapter.clickListener = { it : Currency -> clickItem(it) }
    }

    private fun clickItem(partItem : Currency) {
        if(viewModel.getNavigationId() == ID_ORIGEM) { viewModel.setCurrencyOrigem(partItem.name); }
        if(viewModel.getNavigationId() == ID_DESTINATION) { viewModel.setCurrencyDestination(partItem.name) }

        activity!!.onBackPressed()
    }

    private fun getLocalStore(): CurrencyLayerModel? { return viewModel.getLocalStore(context!!) }

    private fun getAllCurrencies() {
        val currencyLayerModel: CurrencyLayerModel? = getLocalStore()
        if(!currencyLayerModel?.currencies.isNullOrEmpty()) {
            viewModel.setCurrencies(currencyLayerModel?.currencies)
            adapter.atualiza(viewModel.getNameCurrencies())
        } else {
            if(viewModel.getNameCurrencies().isEmpty()) {
                viewModel.getAllCurrencies(context!!).observe(
                    viewLifecycleOwner, Observer { resource ->
                        resource.data?.let { viewModel.setCurrencies(it.currencies);  adapter.atualiza(viewModel.getNameCurrencies()) }
                        resource.error?.let { showError(it) }
                    })
            } else {
                adapter.atualiza(viewModel.getNameCurrencies())
            }

        }
    }

    override fun onStart() {
        super.onStart()
        if(!verifyNetwork()) showError(NO_NETWORK)
    }

    override fun onResume() {
        super.onResume()
        if(!verifyNetwork()) showError(NO_NETWORK)
    }
}
