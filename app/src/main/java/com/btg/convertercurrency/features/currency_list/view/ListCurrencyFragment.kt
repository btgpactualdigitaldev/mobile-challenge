package com.btg.convertercurrency.features.currency_list.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import com.btg.convertercurrency.BR
import com.btg.convertercurrency.R
import com.btg.convertercurrency.base.BaseFragment
import com.btg.convertercurrency.databinding.ListCurrencyFragmentBinding
import com.btg.convertercurrency.features.currency_list.view.adapter.ListCurrencyAdapter
import org.koin.androidx.viewmodel.ext.android.viewModel

class ListCurrencyFragment : BaseFragment() {

    private val listCurrencyViewModel: ListCurrencyViewModel by viewModel()

    private val listCurrencyAdapter by lazy {
        ListCurrencyAdapter()
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        return (DataBindingUtil.inflate(
            inflater,
            R.layout.list_currency_fragment,
            container,
            false
        ) as ListCurrencyFragmentBinding).apply {
            lifecycleOwner = this@ListCurrencyFragment
            lifecycle.addObserver(listCurrencyViewModel)
            setVariable(BR.listCurrencyItem, listCurrencyViewModel.apply {

                rvCurrencyList.run {
                    adapter = listCurrencyAdapter
                }
            })
        }.root

    }

}