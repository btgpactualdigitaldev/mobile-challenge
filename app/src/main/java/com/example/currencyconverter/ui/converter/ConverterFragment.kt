package com.example.currencyconverter.ui.converter

import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import com.example.currencyconverter.R
import com.example.currencyconverter.database.CurrencyModel
import com.example.currencyconverter.databinding.FragmentConverterBinding
import com.example.currencyconverter.utils.Connection
import com.example.currencyconverter.utils.MonetaryMask
import org.koin.androidx.viewmodel.ext.android.viewModel
import java.math.RoundingMode
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.text.NumberFormat
import java.util.*

class ConverterFragment : Fragment(), AdapterView.OnItemSelectedListener, View.OnClickListener {

    private val converterViewModel by viewModel<ConverterViewModel>()
    private var _binding: FragmentConverterBinding? = null
    private val connection = Connection()

    // This property is only valid between onCreateView and
    // onDestroyView.
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        _binding = FragmentConverterBinding.inflate(inflater, container, false)
        val root: View = binding.root

        setListeners()
        observer()
        MonetaryMask(binding.edtOrigin).listen()

        if (connection.connected(requireContext())) {
            converterViewModel.getListFromApi()
        } else {
            converterViewModel.getList()
        }

        return root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    override fun onItemSelected(parent: AdapterView<*>, view: View?, position: Int, id: Long) {
        val value: String = parent.getItemAtPosition(position).toString()
    }

    override fun onNothingSelected(parent: AdapterView<*>?) {
        //Nothing to do
    }

    override fun onClick(v: View) {
        when(v.id){
            binding.btnConvert.id ->{
                if (!isValid()){
                    binding.edtOrigin.error = getString(R.string.edt_error)
                } else{
                    calculate()
                }
            }
            binding.btnReload.id ->{
                if (connection.connected(requireContext())) {
                    converterViewModel.getListFromApi()
                    isEmpty()
                } else {
                    converterViewModel.getList()
                    isEmpty()
                }
            }
        }
    }

    private fun setListeners(){
        binding.spinnerOrigin.onItemSelectedListener = this

        binding.btnConvert.setOnClickListener(this)
        binding.btnReload.setOnClickListener(this)
    }

    private fun observer() {
        converterViewModel.converterList.observe(viewLifecycleOwner, { currency ->

            val list: MutableList<String> = mutableListOf()
            currency.forEach {
                list.add(it.currencyName)
            }
            
            val adapter = ArrayAdapter(requireContext(), android.R.layout.simple_spinner_dropdown_item, list)
            binding.spinnerOrigin.adapter = adapter
            binding.spinnerDestination.adapter = adapter

            isEmpty()
        })
    }

    private fun isValid(): Boolean{
        return binding.edtOrigin.text.toString() != "" && binding.edtOrigin.text.toString() != "0"
    }

    private fun calculate(){
       val valueString = binding.edtOrigin.text.toString().trim()

        val numberFormatter = NumberFormat.getInstance(Locale.GERMAN)
        val value = numberFormatter.parse(valueString)

       val originCurrency = converterViewModel.converterList.value!!.find {
           it.currencyName == binding.spinnerOrigin.selectedItem.toString()
       } as CurrencyModel
        val destinationCurrency = converterViewModel.converterList.value!!.find {
            it.currencyName == binding.spinnerDestination.selectedItem.toString()
        } as CurrencyModel

        if (originCurrency.currencyName != destinationCurrency.currencyName){
            val originCurrencyDollar = value.toDouble() / originCurrency.rate
            val result = (originCurrencyDollar * destinationCurrency.rate)
            val formatter = DecimalFormat("#,##0.00")
            val symbols = DecimalFormatSymbols()
            symbols.decimalSeparator = ','
            symbols.groupingSeparator = '.'
            formatter.roundingMode = RoundingMode.CEILING
            formatter.decimalFormatSymbols = symbols
            val resultFormatted = formatter.format(result).toString()

            binding.txtResult.text = "$resultFormatted (${destinationCurrency.currency})"
            binding.txtResult.setTextColor(ContextCompat.getColor(requireContext(), R.color.white))
        } else{
            binding.txtResult.text = getString(R.string.spinner_error)
            binding.txtResult.setTextColor(ContextCompat.getColor(requireContext(), R.color.red))
            binding.txtResult.gravity = Gravity.CENTER
        }
    }

    private fun isEmpty(): Boolean{
        return if (converterViewModel.converterList.value!!.isEmpty()){
            binding.layoutConverter.visibility = View.INVISIBLE
            binding.layoutError.visibility = View.VISIBLE

            binding.txtError.text = getString(R.string.empty_list)
            false
        } else{
            binding.layoutError.visibility = View.GONE
            binding.layoutConverter.visibility = View.VISIBLE

            true
        }
    }

}