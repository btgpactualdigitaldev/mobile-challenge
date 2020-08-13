package com.curymorais.moneyconversion.currencyList

import android.annotation.SuppressLint
import android.graphics.drawable.ClipDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.OnBackPressedCallback
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.curymorais.moneyconversion.R
import com.curymorais.moneyconversion.currencyConversion.ConversionFragment
import kotlinx.android.synthetic.main.fragment_coin_list.*

class CurrencyListFragment : Fragment() {

    private lateinit var adapter: CurrencyListFragmentAdapter
    private lateinit var viewModel: CurrencyListFragmentViewModel
    lateinit var llm : LinearLayoutManager

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        super.onCreateView(inflater, container, savedInstanceState)
        return inflater.inflate(R.layout.fragment_coin_list, null)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initComponents()
    }

    @SuppressLint("FragmentLiveDataObserve")
    fun initComponents() {
        var code = arguments!!.getInt("code")!!
        adapter = CurrencyListFragmentAdapter(code, activity)
        llm = LinearLayoutManager(activity)

        recycler_item_list.adapter = adapter
        recycler_item_list.layoutManager = llm

        recycler_item_list.addItemDecoration(DividerItemDecoration(context, ClipDrawable.HORIZONTAL))

        viewModel =  ViewModelProvider(this).get(CurrencyListFragmentViewModel::class.java)
        startViewModel()
        activity?.onBackPressedDispatcher?.addCallback(this, object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                activity?.supportFragmentManager?.beginTransaction()?.replace(R.id.container, ConversionFragment())?.commit()
            }
        })
    }

    private fun startViewModel() {
        viewModel.firstPage.observe(viewLifecycleOwner, Observer { itens ->
            itens?.let {
                adapter.updateList(it.currencies)
            }
        })
    }

}