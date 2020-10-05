package academy.mukandrew.currencyconverter.presenter.fragments

import academy.mukandrew.currencyconverter.R
import academy.mukandrew.currencyconverter.commons.AppDI
import academy.mukandrew.currencyconverter.commons.extensions.showBackButton
import academy.mukandrew.currencyconverter.commons.models.UIState
import academy.mukandrew.currencyconverter.commons.models.UIState.ERROR
import academy.mukandrew.currencyconverter.commons.models.UIState.LOADED
import academy.mukandrew.currencyconverter.commons.models.UIState.LOADING
import academy.mukandrew.currencyconverter.commons.models.UIState.NO_CONTENT
import academy.mukandrew.currencyconverter.presenter.MainActivity
import academy.mukandrew.currencyconverter.presenter.models.CurrencyMethodType
import academy.mukandrew.currencyconverter.presenter.viewmodel.CurrencyViewModel
import academy.mukandrew.currencyconverter.presenter.viewmodel.CurrencyViewModelFactory
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.widget.doOnTextChanged
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.lifecycleScope
import kotlinx.android.synthetic.main.fragment_currency_convert.*
import kotlinx.android.synthetic.main.view_empty_state.*
import kotlinx.android.synthetic.main.view_error_state.*
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class CurrencyConvertFragment : Fragment() {

    private val viewModel: CurrencyViewModel by activityViewModels {
        CurrencyViewModelFactory(requireActivity().application, AppDI.getCurrencyUseCase(requireContext()))
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_currency_convert, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        showBackButton(false)
        initListeners()
        requestData()
    }

    private fun initListeners() {
        fromButton.setOnClickListener(::onFromButtonClicked)
        toButton.setOnClickListener(::onToButtonClicked)
        errorRetryButton.setOnClickListener(::requestData)
        emptyRetryButton.setOnClickListener(::requestData)
        valueEditText.doOnTextChanged { text, _, _, _ ->
            lifecycleScope.launch {
                viewModel.calculateConversion(text).collect(::bindConvertedValue)
            }
        }
    }

    private fun onFromButtonClicked(view: View) {
        (requireActivity() as MainActivity).changeFragmentToList(CurrencyMethodType.FROM)
    }

    private fun onToButtonClicked(view: View) {
        (requireActivity() as MainActivity).changeFragmentToList(CurrencyMethodType.TO)
    }

    private fun requestData(view: View? = null) {
        lifecycleScope.launch {
            viewModel.requestCurrencyList().collect(::bindUIState)
        }
    }

    private fun bindConvertedValue(valueConverted: String) {
        resultTextView.text = valueConverted
    }

    private fun bindUIState(state: UIState) {
        if (state == LOADED) initViews()

        showEmptyCurrencies(state == NO_CONTENT)
        showErrorContainer(state == ERROR)
        showLoading(state == LOADING)
    }

    private fun initViews() {
        fromButton.text = viewModel.fromCurrency?.code ?: String()
        toButton.text = viewModel.toCurrency?.code ?: String()
        valueEditText.requestFocus()
    }

    private fun showLoading(show: Boolean) {
        loadingContainer.visibility = if (show) View.VISIBLE else View.INVISIBLE
    }

    private fun showErrorContainer(show: Boolean) {
        errorContainer.visibility = if (show) View.VISIBLE else View.INVISIBLE
    }

    private fun showEmptyCurrencies(show: Boolean) {
        emptyContainer.visibility = if (show) View.VISIBLE else View.INVISIBLE
    }

}