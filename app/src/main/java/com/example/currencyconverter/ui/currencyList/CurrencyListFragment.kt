package com.example.currencyconverter.ui.currencyList

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.widget.SearchView
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.currencyconverter.databinding.FragmentCurrencyListBinding
import com.example.currencyconverter.utils.Connection
import org.koin.androidx.viewmodel.ext.android.viewModel

class CurrencyListFragment : Fragment() {

    private val currencyListViewModel by viewModel<CurrencyListViewModel>()
    private var _binding: FragmentCurrencyListBinding? = null
    private val connection = Connection()

    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentCurrencyListBinding.inflate(inflater, container, false)
        val root: View = binding.root

        binding.recyclerCurrencies.layoutManager = LinearLayoutManager(context)


        if (connection.connected(requireContext())) {
            currencyListViewModel.getListFromApi()
        } else {
            currencyListViewModel.getList()
        }
        observer()


        return root
    }


    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun observer() {
        currencyListViewModel.listOfCurrencies.observe(viewLifecycleOwner, { currency ->
            currency?.let {
                val adapter = Adapter(currencyList = it, textView = binding.txtEmptySearch)
                binding.recyclerCurrencies.adapter = adapter
                search(adapter)
            }
        })
    }

    private fun search(adapter: Adapter) {
        binding.searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                return false
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                adapter.filter.filter(newText)
                return true
            }
        })
    }

}