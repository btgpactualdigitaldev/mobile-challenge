package com.renderson.currency_converter.ui.currencyList

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.renderson.currency_converter.databinding.FragmentCurrencyListBinding
import com.renderson.currency_converter.other.Status
import com.renderson.currency_converter.ui.base.BaseFragment
import com.renderson.currency_converter.ui.main.CurrencyViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class CurrencyListFragment : BaseFragment<FragmentCurrencyListBinding, CurrencyViewModel>() {

    override val viewModel: CurrencyViewModel by viewModels()
    private lateinit var currencyListAdapter: CurrencyListAdapter

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel.getAllCurrencies()

        initViews()
        initList()
    }

    private fun initViews() = with(binding) {
        currencyListAdapter = CurrencyListAdapter()
        rvCurrency.apply {
            adapter = currencyListAdapter
            layoutManager = LinearLayoutManager(activity)
        }
    }

    private fun initList() = with(binding) {
        viewModel.currencies.observe(viewLifecycleOwner, { result ->
            when (result.status) {
                Status.LOADING -> {
                    progress.show()
                }
                Status.SUCCESS -> {
                    progress.hide()
                    rvCurrency.show()
                    result.data.let {
                        val list = viewModel.convertMapToArrayList(it)
                        currencyListAdapter.submitList(list)
                    }
                }
                Status.ERROR -> {
                    progress.hide()
                    rvCurrency.hide()
                    toast(result.message.toString())
                }
            }
        })
    }

    private fun View.show() {
        visibility = View.VISIBLE
    }

    private fun View.hide() {
        visibility = View.GONE
    }

    override fun getViewBinding(
        inflater: LayoutInflater,
        container: ViewGroup?
    ) = FragmentCurrencyListBinding.inflate(inflater, container, false)
}