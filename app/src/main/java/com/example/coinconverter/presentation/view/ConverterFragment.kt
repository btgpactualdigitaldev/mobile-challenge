package com.example.coinconverter.presentation.view

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.coinconverter.R
import com.example.coinconverter.databinding.FragmentConverterBinding
import com.example.coinconverter.domain.model.Quote
import com.example.coinconverter.presentation.viewmodel.ConverterViewModel
import java.text.DecimalFormat

class ConverterFragment : Fragment(), AdapterView.OnItemSelectedListener {

    private lateinit var convertViewModel: ConverterViewModel
    private lateinit var dataBinding: FragmentConverterBinding
    private var listQuotes: List<Quote> = emptyList()
    private lateinit var originCoin: Quote
    private lateinit var destinyCoin: Quote

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        convertViewModel = ViewModelProvider(this).get(ConverterViewModel::class.java)
        convertViewModel.loadQuotes()
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {

        dataBinding = DataBindingUtil.inflate(inflater, R.layout.fragment_converter, container, false)
        return dataBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        var arrayAdapter = ArrayAdapter<String>(
            context!!,
            android.R.layout.simple_list_item_1
        )

        with(dataBinding.spinnerOriginCoin) {
            adapter = arrayAdapter
            onItemSelectedListener = this@ConverterFragment
        }

        with(dataBinding.spinnerDestinyCoin) {
            adapter = arrayAdapter
            onItemSelectedListener = this@ConverterFragment
        }

        convertViewModel.quote.observe(viewLifecycleOwner, Observer {
            listQuotes = it
            arrayAdapter.clear()
            arrayAdapter.addAll(listQuotes.map {
                it.coin
            })
            arrayAdapter.notifyDataSetChanged()
        })

        dataBinding.buttonConvert.setOnClickListener {
            if(dataBinding.editValueToConvert.text.isNullOrBlank()){
                Toast.makeText(context, getString(R.string.value_to_convert_empty), Toast.LENGTH_SHORT).show()
            }else{
                val valueToConvert = dataBinding.editValueToConvert.text.toString()
                val dolarOrigin = valueToConvert.toDouble() / originCoin.value
                val finalValue = destinyCoin.value * dolarOrigin
                dataBinding.editValueConverted.setText(finalValue.toString())
            }
        }
    }

    companion object {
        private val SPINNER_ORIGIN_COIN: Int = R.id.spinner_origin_coin
        private val SPINNER_DESTINY_COIN: Int = R.id.spinner_destiny_coin

        @JvmStatic
        fun newInstance() = ConverterFragment()
    }


    override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
        when(parent?.id){
            SPINNER_ORIGIN_COIN -> {
                for ((index, item) in listQuotes.withIndex()) {
                    if (index == position) {
                        originCoin = listQuotes[position]
                        println(item.coin)
                        break
                    }
                }
            }
            SPINNER_DESTINY_COIN -> {
                for ((index, item) in listQuotes.withIndex()) {
                    if (index == position) {
                        destinyCoin = listQuotes[position]
                        println(item.coin)
                        break
                    }
                }
            }
        }
    }

    override fun onNothingSelected(parent: AdapterView<*>?) {
        TODO("Not yet implemented")
    }
}