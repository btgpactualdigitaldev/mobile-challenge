package com.example.currencies.ui

import android.content.Context
import android.os.Bundle
import android.view.*
import android.view.inputmethod.InputMethodManager
import android.widget.ProgressBar
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SearchView
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.example.currencies.R
import com.example.currencies.listener.EventListener
import com.example.currencies.model.room.CurrenciesModelLocal
import java.util.*

class ListCurrenciesFragment : Fragment() {

    companion object {
        fun newInstance() = ListCurrenciesFragment()
    }

    private lateinit var swipeRefreshLayout: SwipeRefreshLayout
    private lateinit var progressBar: ProgressBar
    private lateinit var mListener: EventListener
    private val mAdapter = ConverterAdapter()
    private var mSortCurrencies: String = ""

    private lateinit var initialList: List<CurrenciesModelLocal>
    var mNewList: MutableList<CurrenciesModelLocal> = arrayListOf()

    private val mConverterViewModel: ConverterViewModel by activityViewModels()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, s: Bundle?): View {

        val root = inflater.inflate(R.layout.list_fragment, container, false)
        val recycler = root.findViewById<RecyclerView>(R.id.recycler_currencies)

        recycler.layoutManager = LinearLayoutManager(context)
        recycler.adapter = mAdapter
        (activity as AppCompatActivity).supportActionBar?.show()
        swipeRefreshLayout = root.findViewById(R.id.swipeRefreshLayout)
        progressBar = root.findViewById(R.id.list_progressBar)
        progressBar.visibility = View.VISIBLE;
        initialList = listOf(CurrenciesModelLocal())

        swipeRefreshLayout.setOnRefreshListener {
            mConverterViewModel.checkCheckConnection()
            mConverterViewModel.connection.observe(viewLifecycleOwner, Observer {
                if (it) {
                    loadCurrenciesRemote()
                    loadRatesRemote()
                } else {
                    swipeRefreshLayout.isRefreshing = false
                    mConverterViewModel.dialogMessage(getString(R.string.no_connection), context)
                }
            })
        }

        mListener = object : EventListener {

            override fun onListClick(abbrev: String, name_currency: String) {

                if (mConverterViewModel.currencyOriginOrFinal.value == (getString(R.string.currency_Origin))) {
                    mConverterViewModel.setCurrencyOrigin(abbrev, name_currency)
                } else {
                    if (mConverterViewModel.currencyOriginOrFinal.value == (getString(R.string.currency_Final))) {
                        mConverterViewModel.setCurrencyFinal(abbrev, name_currency)
                    }
                }
                activity?.supportFragmentManager?.popBackStack();
            }
        }

        setHasOptionsMenu(true)
        observe()
        return root
    }

    override fun onResume() {
        super.onResume()

        val imm = requireActivity().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(requireView().windowToken, 0)

        mAdapter.attachListener(mListener)
        loadCurrenciesLocal()
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.sort_currencies, menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        if (item.itemId == R.id.order_by_abbrev) {
            mConverterViewModel.chooseSortCurrencies(getString(R.string.abbrev_sort))
            return true
        }

        if (item.itemId == R.id.order_by_name) {
            mConverterViewModel.chooseSortCurrencies(getString(R.string.currencies_sort))
            return true
        }

        if (item.itemId == R.id.action_search) {
            val searchView = item.actionView as SearchView

            swipeRefreshLayout.isEnabled = false;

            searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
                override fun onQueryTextSubmit(query: String?): Boolean {
                    return true
                }

                override fun onQueryTextChange(newText: String?): Boolean {
                    if (newText!!.isNotEmpty()) {
                        mNewList.clear()
                        val search = newText.toLowerCase(Locale.getDefault())

                        for (ind in 0 until initialList.count()) {
                            if (initialList[ind].currency.toLowerCase(Locale.getDefault()).contains(search) ||
                                initialList[ind].abbrev.toLowerCase(Locale.getDefault()).contains(search) ) {

                                val model = CurrenciesModelLocal().apply {
                                    this.abbrev = initialList[ind].abbrev
                                    this.currency = initialList[ind].currency
                                }
                                mNewList.add(model)
                            }
                        }
                        mAdapter.updateList(mNewList)
                    } else {
                        mNewList.clear()
                        mAdapter.updateList(initialList)
                    }
                    return true
                }
            })
            return true
        }
        return super.onOptionsItemSelected(item)
    }

    private fun observe() {

        mConverterViewModel.loadCurrenciesRemote.observe(viewLifecycleOwner, Observer{
            loadCurrenciesLocal()
        })

        mConverterViewModel.onFailureMessage.observe(viewLifecycleOwner, Observer {
            mConverterViewModel.dialogMessage(it, context)
        })

        mConverterViewModel.sortCurrencies.observe(viewLifecycleOwner, Observer {
            mSortCurrencies = it
            loadCurrenciesLocal()
        })

        mConverterViewModel.loadCurrenciesLocal.observe(viewLifecycleOwner, Observer {

            progressBar.visibility = View.GONE;
            swipeRefreshLayout.isRefreshing = false
            if (it.count() > 0) {
                if (mSortCurrencies == getString(R.string.currencies_sort)) {
                    val sortedModel = it.sortedBy { it.currency }
                    initialList = sortedModel
                    mAdapter.updateList(sortedModel)
                } else {
                    if (mSortCurrencies == getString(R.string.abbrev_sort)) {
                        val sortedModel = it.sortedBy { it.abbrev }
                        initialList = sortedModel
                        mAdapter.updateList(sortedModel)
                    } else {
                        initialList = it
                        mAdapter.updateList(it)
                    }
                }
            } else {
                mConverterViewModel.dialogMessage(getString(R.string.NO_ROWS_TO_SHOW), context)
            }
        })
    }

    private fun loadCurrenciesRemote() {
        mConverterViewModel.loadCurrenciesRemote()
    }

    private fun loadRatesRemote() {
        mConverterViewModel.loadRatesRemote()
    }

    private fun loadCurrenciesLocal() {
        mConverterViewModel.loadCurrenciesLocal()
    }
}
