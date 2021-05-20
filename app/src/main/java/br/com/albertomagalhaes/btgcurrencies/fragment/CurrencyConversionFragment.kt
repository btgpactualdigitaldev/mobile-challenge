package br.com.albertomagalhaes.btgcurrencies.fragment

import android.app.Activity
import android.app.Dialog
import android.content.Context
import android.os.Bundle
import android.view.View
import android.view.Window
import android.view.inputmethod.InputMethodManager
import android.widget.Button
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.core.widget.addTextChangedListener
import androidx.fragment.app.Fragment
import androidx.lifecycle.observe
import androidx.navigation.NavController
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.DividerItemDecoration
import br.com.albertomagalhaes.btgcurrencies.R
import br.com.albertomagalhaes.btgcurrencies.adapter.CurrencyConversionAdapter
import br.com.albertomagalhaes.btgcurrencies.extension.convertMillisToDateFormat
import br.com.albertomagalhaes.btgcurrencies.extension.convertMillisToHourFormat
import br.com.albertomagalhaes.btgcurrencies.dto.CurrencyDTO
import br.com.albertomagalhaes.btgcurrencies.extension.convertTimestampToDateHour
import br.com.albertomagalhaes.btgcurrencies.extension.showSimpleMessage
import br.com.albertomagalhaes.btgcurrencies.getCurrencyImage
import br.com.albertomagalhaes.btgcurrencies.viewmodel.MainViewModel
import br.com.albertomagalhaes.btgcurrencies.viewmodel.SetupViewModel
import com.btgpactual.currencyconverter.data.framework.retrofit.ClientAPI
import kotlinx.android.synthetic.main.fragment_currency_conversion.*
import org.koin.androidx.viewmodel.ext.android.sharedViewModel
import java.util.*

class CurrencyConversionFragment : Fragment(R.layout.fragment_currency_conversion) {
    val mainViewModel by sharedViewModel<MainViewModel>()
    val setupViewModel by sharedViewModel<SetupViewModel>()
    private val navController: NavController by lazy {
        findNavController()
    }

    var currencyListSelected: MutableList<CurrencyDTO> = mutableListOf()
    val currencyListAdapter = CurrencyConversionAdapter(::changeMainCurrency)

    var currencySelected: CurrencyDTO? = null
    var loadingDialog: Dialog? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        fragment_currency_conversion_rv.apply {
            setHasFixedSize(true)
            adapter = currencyListAdapter
            addItemDecoration(DividerItemDecoration(this.context, DividerItemDecoration.VERTICAL))
        }

        fragment_currency_conversion_tiet_value.addTextChangedListener {
            convertCurrencyList(it.toString())
        }

        fragment_currency_conversion_fab.setOnClickListener {
            navController.navigate(R.id.to_currency_selection_fragment)
        }

        setupViewModel.synchronizeCurrencyListStatus.observe(viewLifecycleOwner) { value ->
            when (value) {
                is ClientAPI.ResponseType.Success<*> -> {
                    updateCurrencyList()
                    loadingDialog?.dismiss()
                }
                is ClientAPI.ResponseType.Fail.NoInternet -> handleSynchronizationError(value)
                is ClientAPI.ResponseType.Fail.Unknown -> handleSynchronizationError(value)
            }
        }

        fragment_currency_conversion_iv_refresh.setOnClickListener {
            showLoading()
            setupViewModel.synchronizeCurrencyList()
        }
        requireActivity().hideKeyboard(view)
    }

    override fun onResume() {
        super.onResume()
        updateCurrencyList()
    }

    fun convertCurrencyList(value:String) {
        currencyListSelected =  mainViewModel.calculateConversion(value, currencyListSelected, currencySelected)
        currencyListAdapter.setList(currencyListSelected)
    }

    fun updateCurrencyList() {
        mainViewModel.getCurrencyList(true) {
            currencyListSelected = it.sortedBy { it.name }.toMutableList()
            if (currencyListSelected.isNullOrEmpty()) {
                showWelcomeDialog()
                return@getCurrencyList
            }
            currencySelected?.let {
                currencyListSelected.removeIf { filter -> filter.code.equals(it.code) }
            } ?: run{
                currencySelected = currencyListSelected.get(0)
                currencyListSelected.removeAt(0)
            }

            updateSelectedCurrency()
            convertCurrencyList(fragment_currency_conversion_tiet_value.text.toString())
        }
    }

    fun changeMainCurrency(currencyDTO: CurrencyDTO) {
        currencySelected?.let { currencyListSelected.add(it) }
        currencySelected = currencyDTO
        currencyListSelected.remove(currencyDTO)
        updateSelectedCurrency()
        convertCurrencyList(fragment_currency_conversion_tiet_value.text.toString())
    }

    fun updateSelectedCurrency() {
        currencySelected?.let {
            fragment_currency_conversion_iv_flag.setImageDrawable(
                getCurrencyImage(
                    requireContext(), it.code.toLowerCase(
                        Locale.getDefault()
                    )
                )
            )
            fragment_currency_conversion_tv_code.text = it.code
            fragment_currency_conversion_tv_last_update.text = getString(
                R.string.last_currency_update, convertTimestampToDateHour(
                    it.timestamp
                )
            )
        }
    }

//    ---------

    fun handleSynchronizationError(failType: ClientAPI.ResponseType.Fail) {
        when (failType) {
            is ClientAPI.ResponseType.Fail.NoInternet -> showSimpleMessage(R.string.no_internet_message)
            is ClientAPI.ResponseType.Fail.Unknown -> showSimpleMessage(R.string.service_unavailable_message)
        }
        loadingDialog?.dismiss()
    }

    fun Context.hideKeyboard(view: View) {
        val inputMethodManager =
            getSystemService(Activity.INPUT_METHOD_SERVICE) as InputMethodManager
        inputMethodManager.hideSoftInputFromWindow(view.windowToken, 0)
    }

    private fun showLoading() {
        loadingDialog = Dialog(requireActivity()).apply {
            requestWindowFeature(Window.FEATURE_NO_TITLE)
            setCancelable(false)
            setContentView(R.layout.dialog_loading)
            findViewById<TextView>(R.id.tv_loading).text =
                getString(R.string.synchronizing_currencies)
            show()
        }
    }

    private fun showWelcomeDialog() = Dialog(requireActivity()).apply {
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        setCancelable(false)
        setContentView(R.layout.dialog_welcome)
        findViewById<Button>(R.id.bt_use_default).setOnClickListener {
            mainViewModel.setDefaultCurrencyListSeleted {
                updateCurrencyList()
                dismiss()
            }
        }
        findViewById<Button>(R.id.bt_select_currency).setOnClickListener {
            dismiss()
            navController.navigate(R.id.to_currency_selection_fragment)
        }
        show()
    }
}