package com.gui.antonio.testebtg.view

import android.content.Context
import android.net.ConnectivityManager
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.navigation.fragment.findNavController
import com.gui.antonio.testebtg.R
import com.gui.antonio.testebtg.data.Currencies
import com.gui.antonio.testebtg.databinding.FragmentMainBinding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class MainFragment : Fragment() {

    private val quotes = arrayListOf<String>()
    private lateinit var symbol: String
    lateinit var binding: FragmentMainBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_main, container, false
        )
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.etValue.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {

            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {

            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                binding.btConvert.isEnabled = !s!!.isEmpty()
            }

        })

        val cm = activity?.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetwork = cm.activeNetworkInfo
        val isConnected: Boolean = activeNetwork?.isConnectedOrConnecting == true

        if (isConnected) {
            (activity as MainActivity).viewModel.getListCurrency().observe(this, Observer {
                binding.progressBar.visibility = View.GONE
                setSpinners(strings(it))
            })
            (activity as MainActivity).viewModel.deleteAndInsertQuotes(quotes)

        } else {
            (activity as MainActivity).viewModel.getListCurrencyOffline().observe(this , Observer {
                binding.progressBar.visibility = View.GONE
                setSpinners(strings(it))
            })
        }

        binding.btConvert.setOnClickListener {

            binding.progressBar2.visibility = View.VISIBLE

            if(isConnected){
                (activity as MainActivity).viewModel.getQuote(symbol).observe(this, Observer {
                    val value = (activity as MainActivity).viewModel.convert(binding.etValue.text.toString().toDouble(), it.value)
                    binding.progressBar2.visibility = View.GONE
                    binding.tvValue.text = value.toString()
                })
            }else{
                (activity as MainActivity).viewModel.getQuoteOffline(symbol).observe(this, Observer {
                    val value = (activity as MainActivity).viewModel.convert(binding.etValue.text.toString().toDouble(), it.value)
                    binding.progressBar2.visibility = View.GONE
                    binding.tvValue.text = value.toString()
                })
            }

        }

        binding.btListCoins.setOnClickListener {
            findNavController().navigate(R.id.action_mainFragment_to_coinsFragment)
        }

        binding.spinnerDestino.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                override fun onNothingSelected(parent: AdapterView<*>?) {
                    CoroutineScope(Dispatchers.IO).launch {
                        symbol = (activity as MainActivity).appDatabase.appDao().getCurrencies()[0].symbol
                    }
                }

                override fun onItemSelected(
                    parent: AdapterView<*>?,
                    view: View?,
                    position: Int,
                    id: Long
                ) {
                    CoroutineScope(Dispatchers.IO).launch {
                        symbol = (activity as MainActivity).appDatabase.appDao().getCurrencies()[position].symbol
                    }
                }

            }
    }

    private fun strings(it: List<Currencies>) : List<String>{
        val data =  arrayListOf<String>()
        it.forEach {
            quotes.add(it.symbol)
            data.add("${it.symbol} - ${it.name}")
        }
        return data
    }

    private fun setSpinners(strings: List<String>) {
        val adapter = ArrayAdapter(
            context!!,
            android.R.layout.simple_spinner_item,
            android.R.id.text1,
            strings
        )
        binding.spinnerOrigem.adapter = adapter
        binding.spinnerDestino.adapter = adapter
    }
}