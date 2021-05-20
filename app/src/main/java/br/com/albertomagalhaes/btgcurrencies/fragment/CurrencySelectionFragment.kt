package br.com.albertomagalhaes.btgcurrencies.fragment

import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.core.content.ContextCompat
import androidx.core.widget.addTextChangedListener
import androidx.fragment.app.Fragment

import androidx.navigation.NavController
import androidx.navigation.fragment.findNavController
import br.com.albertomagalhaes.btgcurrencies.R
import br.com.albertomagalhaes.btgcurrencies.adapter.CurrencySelectionAdapter
import br.com.albertomagalhaes.btgcurrencies.dto.CurrencyDTO
import br.com.albertomagalhaes.btgcurrencies.extension.showSimpleMessage
import br.com.albertomagalhaes.btgcurrencies.viewmodel.MainViewModel
import kotlinx.android.synthetic.main.fragment_currency_selection.*
import org.koin.androidx.viewmodel.ext.android.sharedViewModel

class CurrencySelectionFragment : Fragment(R.layout.fragment_currency_selection) {

    val mainViewModel by sharedViewModel<MainViewModel>()
    var currencyDTOList: MutableList<CurrencyDTO> = mutableListOf()
    var isSortAcending: Boolean = true

    val currencySelectionAdapter =
        CurrencySelectionAdapter(::selectCurrency)

    private val navController: NavController by lazy {
        findNavController()
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        fragment_currency_selection_rv.apply {
            setHasFixedSize(true)
            adapter = currencySelectionAdapter
        }

        mainViewModel.getCurrencyList {
            currencyDTOList = it.sortedBy { it.name }.toMutableList()
            currencySelectionAdapter.setList(currencyDTOList)
            iv_close.visibility = if(currencyDTOList.filter { it.isSelected }.isNullOrEmpty()) View.GONE else View.VISIBLE
        }

        fab.setOnClickListener {
            if (currencyDTOList.filter { it.isSelected }.size < 2) {
                showSimpleMessage(R.string.select_two_currencies)
                return@setOnClickListener
            }
            if (currencyDTOList.filter { it.isSelected }.size > 5) {
                Toast.makeText(
                    requireContext(),
                    getString(R.string.select_max_five_currencies),
                    Toast.LENGTH_SHORT
                ).show()
                return@setOnClickListener
            }

            mainViewModel.updateCurrencyListSelected(currencyDTOList) {
                navController.navigate(R.id.to_currency_conversion_fragment)
            }
        }

        iv_sort.setOnClickListener {
            if (!fragment_currency_list_tiet_search.text.isNullOrBlank()) {
                fragment_currency_list_tiet_search.text = null
                isSortAcending = true
                currencySelectionAdapter.setList(currencyDTOList.sortedBy { it.name })
                iv_sort.setImageDrawable(
                    ContextCompat.getDrawable(
                        requireContext(),
                        R.drawable.ic_sort_asc_24dps_0dpp_black
                    )
                )
            }

            if (isSortAcending) {
                isSortAcending = false
                currencySelectionAdapter.setList(currencyDTOList.sortedByDescending { it.name })
                iv_sort.setImageDrawable(
                    ContextCompat.getDrawable(
                        requireContext(),
                        R.drawable.ic_sort_desc_24dps_0dpp_black
                    )
                )
            } else {
                isSortAcending = true
                currencySelectionAdapter.setList(currencyDTOList.sortedBy { it.name })
                iv_sort.setImageDrawable(
                    ContextCompat.getDrawable(
                        requireContext(),
                        R.drawable.ic_sort_asc_24dps_0dpp_black
                    )
                )
            }
        }

        iv_clear.setOnClickListener {
            fragment_currency_list_tiet_search.text = null
            currencyDTOList.forEach { it.isSelected = false }
            currencySelectionAdapter.setList(currencyDTOList.sortedBy { it.name })
            isSortAcending = true
            iv_sort.setImageDrawable(
                ContextCompat.getDrawable(
                    requireContext(),
                    R.drawable.ic_sort_asc_24dps_0dpp_black
                )
            )
            showSimpleMessage(R.string.currency_list_selected_cleared)
        }

        fragment_currency_list_tiet_search.addTextChangedListener {
            if (it.isNullOrBlank()) {
                return@addTextChangedListener
            }

            currencySelectionAdapter.setList(currencyDTOList.filter { currency ->
                currency.name.contains(it.toString(), true) ||
                        currency.code.contains(it.toString(), true)
            })
        }

        iv_close.setOnClickListener {
            navController.popBackStack()
        }
    }

    fun selectCurrency(currency: CurrencyDTO) {
        if (currency.isSelected) {
            currency.isSelected = false
            currencySelectionAdapter.notifyDataSetChanged()
            return
        }

        if (currencyDTOList.filter { it.isSelected }.size == 5) {
            showSimpleMessage(R.string.select_max_five_currencies)
            return
        }

        currency.isSelected = true
        currencySelectionAdapter.notifyDataSetChanged()
    }

}