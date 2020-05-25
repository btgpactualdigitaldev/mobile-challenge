package com.guioliveiraapps.btg.ui.currencies

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.widget.SearchView
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.guioliveiraapps.btg.MainActivityViewModel
import com.guioliveiraapps.btg.R
import com.guioliveiraapps.btg.room.Currency
import com.guioliveiraapps.btg.util.Util
import kotlinx.android.synthetic.main.fragment_currencies.*
import kotlinx.android.synthetic.main.include_internet_error.*
import kotlinx.android.synthetic.main.include_server_error.*

class CurrenciesFragment : Fragment() {

    private lateinit var viewModel: MainActivityViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        return inflater.inflate(R.layout.fragment_currencies, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        try {
            viewModel =
                ViewModelProviders.of(requireActivity()).get(MainActivityViewModel::class.java)

            rv_currencies.setPadding(
                rv_currencies.paddingLeft,
                rv_currencies.paddingTop + (rv_currencies.paddingTop / 2),
                rv_currencies.paddingRight,
                rv_currencies.paddingBottom
            )

            setupViewModel()
        } catch (e: Exception) {
            Util.showErrorSnackBar(root_view)
        }
    }

    private fun setupViewModel() {
        viewModel.loading.observe(viewLifecycleOwner, Observer {
            if (it) {
                loading.visibility = View.VISIBLE
            } else {
                loading.visibility = View.GONE
            }
        })

        viewModel.internetError.observe(viewLifecycleOwner, Observer {
            if (it) {
                include_internet_error.visibility = View.VISIBLE

                include_server_error.visibility = View.GONE
                loading.visibility = View.GONE
                body.visibility = View.GONE
            } else {
                include_internet_error.visibility = View.GONE
            }
        })

        viewModel.serverError.observe(viewLifecycleOwner, Observer {
            if (it) {
                include_server_error.visibility = View.VISIBLE

                include_internet_error.visibility = View.GONE
                loading.visibility = View.GONE
                body.visibility = View.GONE
            } else {
                include_internet_error.visibility = View.GONE
            }
        })

        viewModel.showFragments.observe(viewLifecycleOwner, Observer {
            if (it) {
                setupAdapter(viewModel.currencies.value!!.sortedBy { it.initials })

                viewModel.loading.postValue(false)
                body.visibility = View.VISIBLE
            }
        })
    }

    private fun setupAdapter(currencies: List<Currency>) {
        rv_currencies.layoutManager =
            LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
        rv_currencies.setHasFixedSize(true)
        val adapter = CurrenciesAdapter(currencies, requireContext())
        rv_currencies.adapter = adapter

        setupSearchViewListener(adapter)
        setupAdapterListener(adapter)
        setupRadioButtonListener(adapter)
        setupButtonListeners()
        setupScrollListener()
    }

    private fun setupRadioButtonListener(adapter: CurrenciesAdapter) {
        rb_initials.isChecked = true

        rb_initials.setOnClickListener {
            adapter.sortByInitials()
            cv_sort.visibility = View.INVISIBLE
        }

        rb_name.setOnClickListener {
            adapter.sortByName()
            cv_sort.visibility = View.INVISIBLE
        }

    }

    private fun setupButtonListeners() {
        btn_try_again_internet.setOnClickListener {
            viewModel.getCurrencies(requireContext())
            viewModel.getQuotes(requireContext())

            loading.visibility = View.VISIBLE
            body.visibility = View.GONE
            viewModel
        }

        btn_try_again_internet.setOnClickListener {
            viewModel.getCurrencies(requireContext())
            viewModel.getQuotes(requireContext())
        }

        btn_try_again_server.setOnClickListener {
            viewModel.getCurrencies(requireContext())
            viewModel.getQuotes(requireContext())
        }

        ib_sort.setOnClickListener {
            if (cv_sort == null) {
                return@setOnClickListener
            }

            if (cv_sort.visibility == View.INVISIBLE) {
                cv_sort.visibility = View.VISIBLE
                return@setOnClickListener
            }

            cv_sort.visibility = View.INVISIBLE
        }
    }

    private fun setupSearchViewListener(adapter: CurrenciesAdapter) {
        search_view.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                search_view.clearFocus()
                return false
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                adapter.filter.filter(newText)
                rv_currencies.scrollToPosition(0)
                return false
            }
        })
    }

    private fun setupAdapterListener(adapter: CurrenciesAdapter) {
        adapter.registerAdapterDataObserver(object : RecyclerView.AdapterDataObserver() {
            override fun onChanged() {
                if (adapter.itemCount == 0) {
                    txt_no_currencies.visibility = View.VISIBLE
                } else {
                    txt_no_currencies.visibility = View.GONE
                }
                super.onChanged()
            }
        })
    }

    private fun setupScrollListener() {
        rv_currencies.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrolled(recylerView: RecyclerView, dx: Int, dy: Int) {
                if (dy > 0 && !search_view.hasFocus()) {
                    cv_search_view.visibility = View.INVISIBLE
                    cv_sort.visibility = View.INVISIBLE
                } else if (dy < 0) {
                    cv_search_view.visibility = View.VISIBLE
                }
            }
        })
    }

}
