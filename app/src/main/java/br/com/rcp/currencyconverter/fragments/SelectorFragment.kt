package br.com.rcp.currencyconverter.fragments

import android.app.SearchManager
import android.content.Context
import android.os.Bundle
import android.util.Log
import android.view.*
import androidx.activity.addCallback
import androidx.appcompat.widget.SearchView
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import br.com.rcp.currencyconverter.R
import br.com.rcp.currencyconverter.adapters.CurrencyListAdapter
import br.com.rcp.currencyconverter.database.entities.Currency
import br.com.rcp.currencyconverter.databinding.FragmentSelectorBinding
import br.com.rcp.currencyconverter.fragments.base.BaseFragment
import br.com.rcp.currencyconverter.fragments.viewmodels.SelectorViewModel

class SelectorFragment : BaseFragment<FragmentSelectorBinding, SelectorViewModel>(), CurrencyListAdapter.OnItemClickListener {
    private val adapter     : CurrencyListAdapter   by lazy { CurrencyListAdapter(this) }
    private val identifier  : String                by lazy { arguments?.getString("identifier") ?: "" }
    private var currency    : Currency?             = null
    private var searchView  : SearchView?           = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setHasOptionsMenu(true)
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.menu_search, menu)
        val searchItem: MenuItem = menu.findItem(R.id.search)
        val searchManager = requireActivity().getSystemService(Context.SEARCH_SERVICE) as SearchManager

        searchItem.let { search ->
            searchView = search.actionView as SearchView?
            searchView!!.setSearchableInfo(searchManager.getSearchableInfo(requireActivity().componentName))
            searchView!!.setOnQueryTextListener(queryTextListener)
        }

        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binder = DataBindingUtil.inflate(inflater, R.layout.fragment_selector, container, false)
        return binder.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        service			            = ViewModelProvider(this)[SelectorViewModel::class.java]
        binder.service              = service
        binder.currencies.adapter   = adapter

        requireActivity().onBackPressedDispatcher.addCallback(viewLifecycleOwner) {
            findNavController().popBackStack(R.id.converter, false)
        }

        super.onViewCreated(view, savedInstanceState)
    }

    override fun onItemClick(view: View, data: Currency) {
        if (identifier.equals("target", true)) {
            findNavController().previousBackStackEntry?.savedStateHandle?.set("target", data)
            findNavController().popBackStack(R.id.converter, false)
        }

        if (identifier.equals("source", true)) {
            findNavController().previousBackStackEntry?.savedStateHandle?.set("source", data)
            findNavController().popBackStack(R.id.converter, false)
        }
    }

    override fun onResume() {
        service.fetch()
        super.onResume()
    }

    private val queryTextListener =  object : SearchView.OnQueryTextListener {
        override fun onQueryTextChange(newText: String): Boolean {
            adapter.filter.filter(newText)
            return true
        }

        override fun onQueryTextSubmit(query: String): Boolean {
            return true
        }
    }
}