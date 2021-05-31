package com.example.desafiobtg.ui.convert

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import com.example.desafiobtg.R
import com.example.desafiobtg.databinding.FragmentConvertBinding
import com.example.desafiobtg.ui.mainactivity.ConvertActivity.Companion.NAV_CONTROL
import com.example.desafiobtg.utilities.Constants
import com.example.desafiobtg.utilities.currencyIsValid
import com.example.desafiobtg.utilities.displayToast
import com.example.desafiobtg.utilities.formatterNumber
import org.koin.android.ext.android.inject
import org.koin.androidx.viewmodel.ext.android.viewModel

class ConvertFragment : Fragment() {

    private lateinit var listener: OnButtonClicked
    private var binding: FragmentConvertBinding? = null
    private val viewModel: ConvertViewModel by viewModel()
    private val convertCalc: ConvertCalc by inject()
    private var currencyMainList: MutableList<String>? = mutableListOf()
    private var currencyTobeConvertedList: MutableList<String>? = mutableListOf()
    private var livePriceList: Map<String, Double>? = mapOf()
    private var arrayAdapter: ArrayAdapter<String>? = null

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        binding = FragmentConvertBinding.inflate(inflater, container, false)
        return binding?.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        if (NAV_CONTROL) {
            clearListCache()
        } else {
            NAV_CONTROL = true
        }

        viewModel.getList()
        viewModel.getPrices()
        setObservables()


        //Observando Spinners
        onMainSpinnerSelectedListener()
        onTobeConvertedSpinnerSelectedListener()

        //Observando btn convert
        onBtnConvertClickListener()

        binding?.btnShowList?.setOnClickListener {
            listener.onclicked()
        }
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        if (context is OnButtonClicked) {
            listener = context
        }
    }

    private fun onBtnConvertClickListener() {
        binding?.btnConvert?.setOnClickListener {
            convert()
        }
    }

    private fun onMainSpinnerSelectedListener() {
        binding?.mainCurrency?.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                val s = binding?.mainCurrency?.getItemAtPosition(position).toString()
                Constants.Api.MAIN_CURRENCY = s
                Constants.Api.POSICAO = position
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {
                Constants.Api.MAIN_CURRENCY = ""
            }
        }
    }

    private fun onTobeConvertedSpinnerSelectedListener() {
        binding?.currencyToBeConverted?.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                val s = binding?.currencyToBeConverted?.getItemAtPosition(position).toString()
                Constants.Api.TO_BE_CONVERTED_CURRENCY = s
                Constants.Api.POSICAO = position

            }

            override fun onNothingSelected(parent: AdapterView<*>?) {
                Constants.Api.TO_BE_CONVERTED_CURRENCY = ""
            }

        }
    }

    private fun setObservables() {
        getCurrencyList()
        getLivePrice()
    }

    private fun getLivePrice() {
        viewModel.onResultLivePrices.observe(viewLifecycleOwner, { livePrices ->
            livePriceList = livePrices.livePrice
        })
    }

    private fun getCurrencyList() {
        viewModel.onResultListOfCurrency.observe(viewLifecycleOwner, { currencyList ->
            currencyList.currencyList?.forEach {
                currencyMainList?.add(it.key)
                currencyTobeConvertedList?.add(it.key)
            }
        })

        viewModel.onResultError.observe(viewLifecycleOwner, {
            this.context?.displayToast(it)
        })
        populateSpinners()
    }

    private fun populateSpinners() {

        currencyMainList?.add(0, ALL_CURRENCY)
        currencyTobeConvertedList?.add(0, ALL_CURRENCY)

        binding?.mainCurrency?.adapter = updateSpinner(currencyMainList as ArrayList<String>?)

        binding?.currencyToBeConverted?.adapter = updateSpinner(currencyTobeConvertedList as ArrayList<String>?)

    }

    private fun clearListCache() {

        currencyMainList?.removeAt(0)
        currencyTobeConvertedList?.removeAt(0)
    }

    private fun updateSpinner(listOfCurrency: ArrayList<String>?): ArrayAdapter<String>? {

        arrayAdapter = context?.let {
            ArrayAdapter(it, R.layout.support_simple_spinner_dropdown_item,
                    listOfCurrency ?: emptyList())
        }
        return arrayAdapter

    }

    private fun convert() {
        if (binding?.mainCurrency?.let { currencyIsValid(it, ALL_CURRENCY) } == true) {
            this.context?.displayToast("Selecione a Moeda a ser convertida")
        }
        val mainCurrency = convertCalc.currencyToDollar(livePriceList)

        val tobeConvertedCurrency = convertCalc.tobeConvertedCurrencyValue(livePriceList)

        if (!binding?.valueToBeConverted?.text.isNullOrEmpty()) {
            val desireValue = binding?.valueToBeConverted?.let { convertCalc.desireValue(it) }

            val result = desireValue?.let { (mainCurrency?.times(tobeConvertedCurrency))?.times(it) }

            binding?.convertedValue?.text = result?.let { formatterNumber(it) }

        } else {
            val result = mainCurrency?.times(tobeConvertedCurrency)
            binding?.convertedValue?.text = result?.let { formatterNumber(result) }
        }
    }

    companion object {
        private const val ALL_CURRENCY: String = "All Currencies"

        fun newInstance(): Fragment {
            return ConvertFragment()
        }
    }

    interface OnButtonClicked {
        fun onclicked()
    }
}
