package com.example.challengecpqi.ui.conversion

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.navigation.fragment.findNavController
import com.example.challengecpqi.R
import com.example.challengecpqi.databinding.FragmentConversionBinding
import com.example.challengecpqi.model.Currency
import com.example.challengecpqi.model.SelectCurrency
import com.example.challengecpqi.model.response.QuotesResponse
import com.example.challengecpqi.ui.MainActivity
import com.example.challengecpqi.util.getDate
import org.koin.androidx.viewmodel.ext.android.viewModel
import org.koin.core.parameter.parametersOf
import java.sql.Timestamp
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.*

class ConversionFragment : Fragment() {

    private val viewModel: ConversionViewModel by viewModel()

    private lateinit var binding: FragmentConversionBinding
    private var quotesResponse: QuotesResponse? = null
    private var valueTo: Currency? = null
    private var valueFrom: Currency? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_conversion, container, false)

        initViews()
        observables()
        viewModel.getData()
        return binding.root
    }

    private fun initViews() {
        (activity as MainActivity).setSupportActionBar(binding.layoutToolbar.toolbar)

        binding.btnFrom.setOnClickListener {
            val bundle = bundleOf("value" to SelectCurrency.FROM)
            findNavController().navigate(R.id.action_navigation_conversion_to_navigation_list, bundle)
        }

        binding.btnTo.setOnClickListener {
            val bundle = bundleOf("value" to SelectCurrency.TO)
            findNavController().navigate(R.id.action_navigation_conversion_to_navigation_list, bundle)
        }

        binding.edtValue.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {
                if (!s.isNullOrEmpty()) {
                    val value = s.toString().toDouble()
                    calcQuote(value)
                } else {
                    calcQuote(null)
                }
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {

            }
        })
    }

    private fun observables() {
        viewModel.responseQuotes.observe(viewLifecycleOwner, Observer {
            quotesResponse = it
            val dateFormat = getString(R.string.last_update).format(getDate(it.timestamp))
            (activity as MainActivity).supportActionBar?.subtitle = dateFormat
        })

        viewModel.errorMsg.observe(viewLifecycleOwner, Observer {
            Toast.makeText(requireContext(), it, Toast.LENGTH_SHORT).show()
        })

        findNavController().currentBackStackEntry?.savedStateHandle?.getLiveData<Currency>("fromCurrency")
            ?.observe(viewLifecycleOwner, Observer {
                valueFrom = it
                val value = "${it.value} ${it.key}"
                binding.btnFrom.text = value
            })

        findNavController().currentBackStackEntry?.savedStateHandle?.getLiveData<Currency>("toCurrency")
            ?.observe(viewLifecycleOwner, Observer {
                valueTo = it
                val value = "${it.value} ${it.key}"
                binding.btnTo.text = value
            })
    }

    private fun calcQuote(value: Double? = null) {
        if (!valueFrom?.key.isNullOrEmpty() && !valueTo?.key.isNullOrEmpty()) {
            val valueFrom = searchKeys(valueFrom?.key!!)
            val valueTo = searchKeys(valueTo?.key!!)

            var valueFromDollar = 0.0
            if (value != null) {
                valueFromDollar = convertInDollar(value, valueFrom)
            }
            val valueResult = (valueFromDollar * valueTo).toString()

            binding.txtResult.text = getString(R.string.result).format(String.format("%.4f", valueResult.toFloat()))
        }
    }

    private fun searchKeys(value: String): Double {
        quotesResponse?.quotes?.first {
            it.key.substring(3, 6) == value
        }.also {
            binding.txtResult.text = it?.value.toString()
            return it?.value!!
        }
    }

    private fun convertInDollar(origin : Double, destine: Double) : Double {
        return origin.div(destine)
    }
}