package com.btgpactual.currencyconverter.ui.fragment

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.util.TypedValue
import android.view.View
import androidx.appcompat.content.res.AppCompatResources.getDrawable
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.observe
import androidx.navigation.NavController
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.RecyclerView
import com.btgpactual.currencyconverter.R
import com.btgpactual.currencyconverter.data.framework.roomdatabase.AppDatabase
import com.btgpactual.currencyconverter.data.framework.roomdatabase.dao.ConversionDAO
import com.btgpactual.currencyconverter.data.framework.roomdatabase.dao.CurrencyDAO
import com.btgpactual.currencyconverter.data.framework.roomdatabase.repository.ConversionRoomDatabase
import com.btgpactual.currencyconverter.data.framework.roomdatabase.repository.CurrencyRoomDatabase
import com.btgpactual.currencyconverter.data.repository.ConversionInternalRepository
import com.btgpactual.currencyconverter.data.repository.CurrencyInternalRepository
import com.btgpactual.currencyconverter.ui.adapter.CurrencyConversionListAdapter
import com.btgpactual.currencyconverter.ui.callback.SwipeCallback
import com.btgpactual.currencyconverter.ui.viewmodel.CurrencyViewModel
import com.btgpactual.currencyconverter.util.*
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.fragment_currency_conversion.*
import java.util.*

class CurrencyConversionFragment : Fragment(R.layout.fragment_currency_conversion) {

    private val navController: NavController by lazy {
        findNavController()
    }

    private val viewModel: CurrencyViewModel by activityViewModels {
        object : ViewModelProvider.Factory {
            override fun <T : ViewModel?> create(modelClass: Class<T>): T {
                val conversionDAO: ConversionDAO =
                    AppDatabase.getInstance(requireContext()).conversionDAO

                val conversionInternalRepository: ConversionInternalRepository =
                    ConversionRoomDatabase(
                        conversionDAO
                    )

                val currencyDAO: CurrencyDAO =
                    AppDatabase.getInstance(requireContext()).currencyDAO

                val currencyInternalRepository: CurrencyInternalRepository =
                    CurrencyRoomDatabase(
                        currencyDAO
                    )
                return CurrencyViewModel(
                    conversionInternalRepository,
                    currencyInternalRepository
                ) as T
            }
        }
    }

    private val textWatcherInitialCurrencyValue = generateTextWatcherByCurrencyType(CurrencyViewModel.CurrencyType.Initial)
    private val textWatcherFinalCurrencyValue = generateTextWatcherByCurrencyType(CurrencyViewModel.CurrencyType.Final)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        observeEvents()
        setListeners()

        if(viewModel.initialCurrencyLiveData.value==null){
            viewModel.setDefaultCurrency(CurrencyViewModel.CurrencyType.Initial)
        }

        if(viewModel.finalCurrencyLiveData.value==null){
            viewModel.setDefaultCurrency(CurrencyViewModel.CurrencyType.Final)
        }

        viewModel.setConversionList()
    }

    private fun observeEvents() {

        viewModel.conversionListLiveData.observe(viewLifecycleOwner) { value ->
            if(value.isEmpty()){
                fragment_currency_conversion_vf.displayedChild = 0
                return@observe
            }

            fragment_currency_conversion_vf.displayedChild = 1

            val adapter =
                CurrencyConversionListAdapter(
                    value
                )
            val itemTouchhelper = ItemTouchHelper(object : SwipeCallback(requireContext()) {
                override fun onSwiped(viewHolder: RecyclerView.ViewHolder, i: Int) {
                    viewModel.deleteConversion(viewHolder.adapterPosition)
                }
            })
            itemTouchhelper.attachToRecyclerView(fragment_currency_conversion_rv)
            with(fragment_currency_conversion_rv) {
                setHasFixedSize(true)
                this.adapter = adapter
            }
        }

        viewModel.conversionStateLiveData.observe(viewLifecycleOwner) { value ->

            when(value){
                is CurrencyViewModel.ConversionState.ConversionSaved ->{
                    fragment_currency_conversion_tiet_initial_currency_value.clearTextWithNoTextWatcher(textWatcherInitialCurrencyValue)
                    fragment_currency_conversion_tiet_final_currency_value.clearTextWithNoTextWatcher(textWatcherFinalCurrencyValue)
                    fragment_currency_conversion_tv_currency_update_date_hour.text = ""
                }
                is CurrencyViewModel.ConversionState.ConversionNotSaved ->{
                    Snackbar.make(requireView(), value.messageResId, Snackbar.LENGTH_LONG).show()
                }
                is CurrencyViewModel.ConversionState.ConversionSuccessful -> {
                    fragment_currency_conversion_tiet_initial_currency_value.run {
                        setTextWithNoTextWatcher(value.initial,textWatcherInitialCurrencyValue)
                        setAdequateTextSize()
                        setSelectionToEnd()
                    }

                    fragment_currency_conversion_tiet_final_currency_value.run {
                        setTextWithNoTextWatcher(value.final,textWatcherFinalCurrencyValue)
                        setAdequateTextSize()
                        setSelectionToEnd()
                    }
                    fragment_currency_conversion_tv_currency_update_date_hour.text = getString(R.string.currency_view_model_date_hour_last_update, value.dateHour)
                }
                CurrencyViewModel.ConversionState.ConversionEmptyValueFound -> {

                    fragment_currency_conversion_tiet_initial_currency_value.run {
                        clearTextWithNoTextWatcher(textWatcherInitialCurrencyValue)
                        setAdequateTextSize()
                        setSelectionToEnd()
                    }

                    fragment_currency_conversion_tiet_final_currency_value.run {
                        clearTextWithNoTextWatcher(textWatcherFinalCurrencyValue)
                        setAdequateTextSize()
                        setSelectionToEnd()
                    }

                    fragment_currency_conversion_tv_currency_update_date_hour.text = ""
                }
                is CurrencyViewModel.ConversionState.ConversionInputMaxValueReached -> {

                    fragment_currency_conversion_tiet_initial_currency_value.run {
                        setTextWithNoTextWatcher(value.maxValue,textWatcherInitialCurrencyValue)
                        setAdequateTextSize()
                        setSelectionToEnd()
                    }

                    fragment_currency_conversion_tiet_final_currency_value.run {
                        clearTextWithNoTextWatcher(textWatcherFinalCurrencyValue)
                        setAdequateTextSize()
                        setSelectionToEnd()
                    }

                    showSimpleMessage(requireContext(),getString(value.messageResId,value.maxValueDigitCount))
                }
                is CurrencyViewModel.ConversionState.ConversionOutputMaxValueReached -> {

                    fragment_currency_conversion_tiet_final_currency_value.run {
                        clearTextWithNoTextWatcher(textWatcherFinalCurrencyValue)
                        setAdequateTextSize()
                        setSelectionToEnd()
                    }

                    fragment_currency_conversion_tiet_initial_currency_value.setSelectionToEnd()

                    showSimpleMessage(requireContext(),getString(value.messageResId,value.maxValueDigitCount))
                }
            }

        }

        viewModel.initialCurrencyLiveData.observe(viewLifecycleOwner) { value ->
            fragment_currency_conversion_tv_initial_currency_code.text = value.codigo

            val drawable = getDrawable(requireContext(),R.drawable.flag_unk)

            fragment_currency_conversion_iv_initial_currency_flag.setImageDrawable(
                getFlag(requireContext(),value.codigo.toLowerCase(
                    Locale.getDefault())) ?:drawable)
        }

        viewModel.finalCurrencyLiveData.observe(viewLifecycleOwner) { value ->
            fragment_currency_conversion_tv_final_currency.text = value.codigo

            val drawable = getDrawable(requireContext(),R.drawable.flag_unk)

            fragment_currency_conversion_iv_final_currency.setImageDrawable(
                getFlag(requireContext(),value.codigo.toLowerCase(
                    Locale.getDefault())) ?:drawable)
        }

    }

    private fun setListeners() {

        fragment_currency_conversion_ll_initial_currency.setOnClickListener {
            viewModel.currencySelectedToChange = CurrencyViewModel.CurrencyType.Initial
            navController.navigate(R.id.action_conversionFragment_to_currencyListFragment)
        }

        fragment_currency_conversion_ll_final_currency.setOnClickListener {
            viewModel.currencySelectedToChange = CurrencyViewModel.CurrencyType.Final
            navController.navigate(R.id.action_conversionFragment_to_currencyListFragment)
        }

        fragment_currency_conversion_tiet_initial_currency_value.addTextChangedListener (textWatcherInitialCurrencyValue)
        fragment_currency_conversion_tiet_final_currency_value.addTextChangedListener (textWatcherFinalCurrencyValue)

        fragment_currency_conversion_acib_switch_currency.setOnClickListener {
            viewModel.switchInitialCurrencyWithFinalCurrency()

            if(fragment_currency_conversion_tiet_final_currency_value.isFocused){
                viewModel.calculateConversion(CurrencyViewModel.CurrencyType.Final,fragment_currency_conversion_tiet_final_currency_value.text.toString())
            }else{
                viewModel.calculateConversion(CurrencyViewModel.CurrencyType.Initial,fragment_currency_conversion_tiet_initial_currency_value.text.toString())
            }

        }

        fragment_currency_conversion_acib_clear_currency_value.setOnClickListener {
            fragment_currency_conversion_tiet_initial_currency_value.clearTextWithNoTextWatcher(textWatcherInitialCurrencyValue)
            fragment_currency_conversion_tiet_final_currency_value.clearTextWithNoTextWatcher(textWatcherFinalCurrencyValue)
        }

        fragment_currency_conversion_efab_save.setOnClickListener {
            val initialCurrencyValue = fragment_currency_conversion_tiet_initial_currency_value.text.toString()
            val finalCurrencyValue = fragment_currency_conversion_tiet_final_currency_value.text.toString()
            viewModel.saveConversion(initialCurrencyValue,finalCurrencyValue)
        }
    }

    private fun generateTextWatcherByCurrencyType(currencyType: CurrencyViewModel.CurrencyType) : TextWatcher {
        return object : TextWatcher {
            override fun onTextChanged(
                s: CharSequence,
                start: Int,
                before: Int,
                count: Int
            ) {

                when(currencyType){
                    CurrencyViewModel.CurrencyType.Initial ->{
                        viewModel.calculateConversion(CurrencyViewModel.CurrencyType.Initial,fragment_currency_conversion_tiet_initial_currency_value.text.toString())
                    }
                    CurrencyViewModel.CurrencyType.Final ->{
                        viewModel.calculateConversion(CurrencyViewModel.CurrencyType.Final,fragment_currency_conversion_tiet_final_currency_value.text.toString())
                    }
                }
            }
            override fun beforeTextChanged(
                s: CharSequence, start: Int, count: Int,
                after: Int
            ) {}
            override fun afterTextChanged(s: Editable) {}
        }
    }
}