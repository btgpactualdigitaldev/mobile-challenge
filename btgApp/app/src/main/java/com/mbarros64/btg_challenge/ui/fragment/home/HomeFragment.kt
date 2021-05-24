package com.mbarros64.btg_challenge.ui.fragment.home

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.lifecycle.Observer
import com.mbarros64.btg_challenge.databinding.FragmentHomeBinding
import com.mbarros64.btg_challenge.utils.MonetaryEditTextMask
import com.google.android.material.snackbar.Snackbar
import org.koin.android.viewmodel.ext.android.viewModel

class HomeFragment : Fragment(), AdapterView.OnItemSelectedListener {

    private val homeViewModel : HomeViewModel by viewModel()
    private var binding : FragmentHomeBinding ?= null
    private var arrayAdapter : ArrayAdapter<String> ?= null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentHomeBinding.inflate(inflater, container, false)


        context ?: return binding?.root
        return binding?.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        observerError()
        observerEmptyList()
        observerCurrencyOutput()
        initObserver()
        converterCurrency()
    }

    private fun initObserver() {
        homeViewModel.getCurrencies().observe(viewLifecycleOwner, Observer {
            it?.let {
                observerCurrencyList()
            }?: binding?.failLayout?.visibility
        })
    }

    private fun observerEmptyList() {
        homeViewModel.emptyList.observe(viewLifecycleOwner, Observer {
            it?.let {
                if (it) {
                    binding?.failLayout?.visibility = View.VISIBLE
                } else {
                    binding?.failLayout?.visibility = View.GONE
                }
            }
        })
    }

    private fun observerCurrencyOutput() {
        homeViewModel.convertedCurrency.observe(viewLifecycleOwner, Observer {
            binding?.outputTextView?.text = it.toString()
        })
    }

    private fun observerCurrencyList() {
        homeViewModel.getCurrenciesInitials().observe(viewLifecycleOwner, Observer {
            it?.let {
                arrayAdapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_item, it)
                binding?.bySpinner?.adapter = arrayAdapter
                binding?.toSpinner?.adapter = arrayAdapter


                binding?.bySpinner?.onItemSelectedListener = this
                binding?.toSpinner?.onItemSelectedListener = this
            }
        })
    }

    private fun converterCurrency() {
        binding?.converterButton?.setOnClickListener {
            homeViewModel.convertCurrencyAtoCurrencyB(binding?.inputTextField?.text)
        }
    }

    private fun observerError() {
       homeViewModel.error.observe(viewLifecycleOwner, Observer {
           val snackbar: Snackbar = Snackbar.make(requireView(), it, Snackbar.LENGTH_SHORT)

           snackbar.setAction("OK") {
               snackbar.dismiss()
           }
           snackbar.show()
       })
    }

    override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
        if(parent?.id == binding?.bySpinner?.id)
            homeViewModel.byCurrencyAdapter.postValue(position)
        else homeViewModel.toCurrencyAdapter.postValue(position)
    }

    override fun onNothingSelected(parent: AdapterView<*>?) {
        TODO("Not yet implemented")
    }
}