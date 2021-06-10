package clcmo.com.btgcurrency.view.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.widget.doOnTextChanged
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.lifecycleScope
import clcmo.com.btgcurrency.R
import clcmo.com.btgcurrency.util.AppInject.getUserCase
import clcmo.com.btgcurrency.util.constants.Constants
import clcmo.com.btgcurrency.util.constants.Constants.State.*
import clcmo.com.btgcurrency.util.constants.Constants.CMethodType.*
import clcmo.com.btgcurrency.util.extension.backButtonView
import clcmo.com.btgcurrency.view.MainActivity
import clcmo.com.btgcurrency.viewmodel.CViewModel
import clcmo.com.btgcurrency.viewmodel.CViewModelFactory
import kotlinx.android.synthetic.main.c_convert_fragment.*
import kotlinx.android.synthetic.main.error_view.*
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch


class CConverterFragment : Fragment() {

    private val cViewModel: CViewModel by activityViewModels {
        CViewModelFactory(
            requireActivity().application,
            getUserCase(requireContext())
        )
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? = inflater.inflate(R.layout.c_convert_fragment, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        backButtonView(false)
        startListeners()
        requestCurrencyList()
    }

    private fun startListeners() {
        fromBt.setOnClickListener(::onFromBtClicked)
        toBt.setOnClickListener(::onToBtClicked)
        errorBt.setOnClickListener(::requestCurrencyList)
        valueET.doOnTextChanged { text, _, _, _ ->
            lifecycleScope.launch {
                cViewModel.calcConvert(text).collect(::bindConvertedValue)
            }
        }

    }

    private fun onFromBtClicked(view: View) =
        (requireActivity() as MainActivity).convertFragmentToList(FROM)


    private fun onToBtClicked(view: View) =
        (requireActivity() as MainActivity).convertFragmentToList(TO)

    private fun requestCurrencyList(view: View? = null) = lifecycleScope.launch {
        cViewModel.requestListOfCurrencies().collect(::bindState)
    }

    private fun bindConvertedValue(valueConverted: String) {
        resultTV.text = valueConverted
    }

    private fun bindState(state: Constants.State) = when (state) {
        LOADED -> initButtonViews()
        ERROR -> showError(state == state)
        CONTENT_EX -> showError(state == state)
        LOADING -> showLoading(state == state)
    }

    private fun initButtonViews() {
        fromBt.text = cViewModel.fromCurrency?.id ?: String()
        toBt.text = cViewModel.toCurrency?.id ?: String()
        valueET.requestFocus()
    }

    private fun showLoading(show: Boolean) {
        loading.visibility = when {
            show -> View.VISIBLE
            else -> View.INVISIBLE
        }
    }

    private fun showError(show: Boolean) {
        error.visibility = when {
            show -> View.VISIBLE
            else -> View.INVISIBLE
        }
    }
}