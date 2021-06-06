package com.example.exchange.fragment

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.exchange.R
import com.example.exchange.databinding.FragmentCoinBinding
import com.example.exchange.model.CoinDetails
import com.example.exchange.utils.CoinAdapter
import com.example.exchange.viewmodel.CoinViewModel

class CoinFragment : Fragment(R.layout.fragment_coin) {

    private lateinit var viewModel: CoinViewModel
    private lateinit var binding: FragmentCoinBinding

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding = FragmentCoinBinding.bind(view)

        viewModel = ViewModelProviders.of(this).get(CoinViewModel::class.java)

        initObservers()
        initListeners()

        viewModel.requestData()
    }

    private fun initObservers() {
        viewModel.getData().observe(viewLifecycleOwner, {
            fillAdapter(it)
        })

        viewModel.getLoading().observe(viewLifecycleOwner, {
            binding.progressbarCoin.visibility = it
        })

        viewModel.getError().observe(viewLifecycleOwner, {
            // TODO include dialog error
        })
    }

    private fun initListeners() {
        binding.edittextSearch.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
            }

            override fun afterTextChanged(s: Editable?) {
                viewModel.createDataList(s.toString())
            }
        })
    }

    private fun fillAdapter(item: List<CoinDetails>) {
        with(binding.recyclerviewCoin) {
            adapter = CoinAdapter(item)
            layoutManager = LinearLayoutManager(context)
        }
    }
}