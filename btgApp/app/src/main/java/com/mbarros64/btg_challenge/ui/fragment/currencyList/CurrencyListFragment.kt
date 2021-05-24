package com.mbarros64.btg_challenge.ui.fragment.currencyList

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.SearchView
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import com.mbarros64.btg_challenge.R
import com.mbarros64.btg_challenge.databinding.FragmentCurrencyListBinding
import com.mbarros64.btg_challenge.ui.fragment.currencyList.adapter.CurrencyListAdapter
import com.google.android.material.snackbar.Snackbar
import org.koin.android.viewmodel.ext.android.viewModel

class CurrencyListFragment : Fragment() {

    private val listViewModel : CurrencyListViewModel by viewModel()
    private var binding : FragmentCurrencyListBinding?= null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentCurrencyListBinding.inflate(inflater, container, false)

        context ?: return binding?.root
        return binding?.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        observerError()
        observerEmptyList()
        observerList()
    }

    private fun searchCurrency(adapter: CurrencyListAdapter) {
        binding?.searchText?.setOnQueryTextListener(object  : SearchView.OnQueryTextListener,
            androidx.appcompat.widget.SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                return false
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                adapter.filter.filter(newText)
                return false
            }

        })
    }

    private fun observerEmptyList() {
        listViewModel.emptyList.observe(viewLifecycleOwner, Observer {
            it?.let {
                if (it) {
                    binding?.failLayout?.visibility = View.VISIBLE
                } else {
                    binding?.failLayout?.visibility = View.GONE
                }
            }
        })
    }

    private fun observerList() {
        listViewModel.getCurrencyList().observe(viewLifecycleOwner, Observer { currencies ->
            currencies?.let {
                val adapter = CurrencyListAdapter(currencies = it)
                binding?.currenciesList?.adapter = adapter

                searchCurrency(adapter)
            }
        })
    }

    private fun observerError() {
        listViewModel.error.observe(viewLifecycleOwner, Observer {
            val snackbar: Snackbar = Snackbar.make(requireView(), it, Snackbar.LENGTH_SHORT)

            snackbar.setAction("OK") {
                snackbar.dismiss()
            }
            snackbar.show()
        })
    }
}