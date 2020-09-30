package com.btgpactual.currencyconverter.ui.fragment

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.Menu
import android.view.MenuInflater
import android.view.MenuItem
import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.widget.addTextChangedListener
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.observe
import androidx.navigation.NavController
import androidx.navigation.fragment.findNavController
import com.btgpactual.currencyconverter.R
import com.btgpactual.currencyconverter.data.framework.roomdatabase.AppDatabase
import com.btgpactual.currencyconverter.data.framework.roomdatabase.dao.ConversionDAO
import com.btgpactual.currencyconverter.data.framework.roomdatabase.dao.CurrencyDAO
import com.btgpactual.currencyconverter.data.framework.roomdatabase.repository.ConversionRoomDatabase
import com.btgpactual.currencyconverter.data.framework.roomdatabase.repository.CurrencyRoomDatabase
import com.btgpactual.currencyconverter.data.repository.ConversionInternalRepository
import com.btgpactual.currencyconverter.data.repository.CurrencyInternalRepository
import com.btgpactual.currencyconverter.ui.adapter.CurrencyListAdapter
import com.btgpactual.currencyconverter.ui.viewmodel.CurrencyViewModel
import com.btgpactual.currencyconverter.util.clearTextWithNoTextWatcher
import com.btgpactual.currencyconverter.util.setTextWithNoTextWatcher
import kotlinx.android.synthetic.main.fragment_currency_conversion.*
import kotlinx.android.synthetic.main.fragment_currency_list.*


class CurrencyListFragment : Fragment(R.layout.fragment_currency_list) {

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
    private val textWatcher = generateTextWatcher()

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        setListeners()
        observeEvents()

        viewModel.setCurrencyList()
    }


    private fun setListeners() {
        fragment_currency_list_tiet_search.addTextChangedListener(textWatcher)

        fragment_currency_list_iv_filter_code.setOnClickListener {
            fragment_currency_list_tiet_search.clearTextWithNoTextWatcher(textWatcher)
            viewModel.setCurrencyList(CurrencyViewModel.SortType.Code.NextSort)
        }

        fragment_currency_list_iv_filter_name.setOnClickListener {
            fragment_currency_list_tiet_search.clearTextWithNoTextWatcher(textWatcher)
            viewModel.setCurrencyList(CurrencyViewModel.SortType.Name.NextSort)
        }

    }

    private fun observeEvents() {

        viewModel.currencyListLiveData.observe(viewLifecycleOwner) { value ->
            val adapter =
                CurrencyListAdapter(
                    value
                ) { currencyModel ->
                    viewModel.setCurrencySelectedToChange(currencyModel)

                    navController.popBackStack()
                }

            with(fragment_currency_list_rv) {
                setHasFixedSize(true)
                this.adapter = adapter
            }
        }

        viewModel.currencyListCurrentSortType.observe(viewLifecycleOwner) { value ->

            fragment_currency_list_iv_filter_name.setImageDrawable(
                ContextCompat.getDrawable(
                    requireContext(),
                    R.drawable.ic_swap_vert_24
                )
            )
            fragment_currency_list_iv_filter_code.setImageDrawable(
                ContextCompat.getDrawable(
                    requireContext(),
                    R.drawable.ic_swap_vert_24
                )
            )

            when(value){
                CurrencyViewModel.SortType.Code.Ascending -> fragment_currency_list_iv_filter_code.setImageDrawable(
                    ContextCompat.getDrawable(
                        requireContext(),
                        R.drawable.ic_sort_alpha_asc_24
                    )
                )
                CurrencyViewModel.SortType.Code.Descending -> fragment_currency_list_iv_filter_code.setImageDrawable(
                    ContextCompat.getDrawable(
                        requireContext(),
                        R.drawable.ic_sort_alpha_desc_24
                    )
                )
                CurrencyViewModel.SortType.Name.Ascending -> fragment_currency_list_iv_filter_name.setImageDrawable(
                    ContextCompat.getDrawable(
                        requireContext(),
                        R.drawable.ic_sort_alpha_asc_24
                    )
                )
                CurrencyViewModel.SortType.Name.Descending -> fragment_currency_list_iv_filter_name.setImageDrawable(
                    ContextCompat.getDrawable(
                        requireContext(),
                        R.drawable.ic_sort_alpha_desc_24
                    )
                )
            }
        }

    }

    private fun generateTextWatcher() : TextWatcher {
        return object : TextWatcher {
            override fun onTextChanged(
                s: CharSequence,
                start: Int,
                before: Int,
                count: Int
            ) {
                viewModel.setCurrencyList(CurrencyViewModel.SortType.Text(fragment_currency_list_tiet_search.text.toString()))
            }
            override fun beforeTextChanged(
                s: CharSequence, start: Int, count: Int,
                after: Int
            ) {}
            override fun afterTextChanged(s: Editable) {}
        }
    }

}