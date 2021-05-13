package br.com.btg.btgchallenge.ui.fragments.currencylist

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.SearchView
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import br.com.btg.btgchallenge.R
import br.com.btg.btgchallenge.databinding.FragmentCurrencyListBinding
import br.com.btg.btgchallenge.network.api.config.Resource
import br.com.btg.btgchallenge.network.api.config.Status
import br.com.btg.btgchallenge.ui.fragments.conversions.Currency
import br.com.btg.btgchallenge.ui.fragments.conversions.CurrencyClicked
import br.com.btg.btgchallenge.ui.fragments.conversions.CurrencyType
import kotlinx.android.synthetic.main.fragment_currency_list.*
import org.koin.android.viewmodel.ext.android.viewModel


class FragmentCurrencyList(val currencyType: CurrencyType, val listener: (Currency) -> Unit) : DialogFragment() {

    val currencyListViewModel: CurrencyListViewModel by viewModel()
    private lateinit var binding: FragmentCurrencyListBinding
    private lateinit var adapter: CurrencyAdapter

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?
    ): View? {
        super.onCreateView(inflater, container, savedInstanceState)
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_currency_list, container, false)
        binding.viewModel = currencyListViewModel
        binding.lifecycleOwner = this
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        getCurrencies()
    }

    override fun onResume() {
        super.onResume()
        val params: ViewGroup.LayoutParams = dialog!!.window!!.attributes
        params.width = ViewGroup.LayoutParams.MATCH_PARENT
        params.height = ViewGroup.LayoutParams.MATCH_PARENT
        dialog!!.window!!.attributes = params as WindowManager.LayoutParams
    }

    fun setCurrencyList(currencies: Map<String, String>?)
    {
        if(currencies != null && currencies.size > 0) {
            recycler_currency_list.layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
            adapter = CurrencyAdapter(currencies, requireContext(), currencyType){
                listener.invoke(it)
            }
            recycler_currency_list.adapter = adapter

        }
        else{
            Toast.makeText(requireContext(), resources.getString(R.string.no_data_found), Toast.LENGTH_LONG).show()
        }
    }

    fun getCurrencies()
    {
        currencyListViewModel.getCurrencies.observe(viewLifecycleOwner, observerCurrencies)
        currencyListViewModel.getCurrencies()
    }

    private val observerCurrencies = Observer<Resource<Any>> {
        when (it.status) {
            Status.SUCCESS -> {
                loader_currency_list.visibility = View.GONE
                recycler_currency_list.visibility = View.VISIBLE
                setCurrencyList(it.data?.currencies)
                setSearchView()
            }
            Status.ERROR -> {
                Toast.makeText(requireContext(), it.message, Toast.LENGTH_LONG).show()
            }
            Status.LOADING -> {
                loader_currency_list.visibility = View.VISIBLE
                recycler_currency_list.visibility = View.GONE
            }
        }
    }

    fun setSearchView()
    {
        currency_search_view.setOnQueryTextListener(object: SearchView.OnQueryTextListener{
            override fun onQueryTextSubmit(query: String?): Boolean {
                return false
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                adapter.filter.filter(newText)
                return false
            }
        })
    }
}