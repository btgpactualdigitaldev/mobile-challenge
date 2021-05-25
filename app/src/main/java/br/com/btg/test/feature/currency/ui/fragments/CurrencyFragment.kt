package br.com.btg.test.feature.currency.ui.fragments

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import br.com.btg.test.base.BaseFragment
import br.com.btg.test.data.Status
import br.com.btg.test.feature.currency.persistence.CurrencyEntity
import br.com.btg.test.feature.currency.ui.CurrenciesListActivity
import br.com.btg.test.feature.currency.viewmodel.CurrencyViewModel
import br.com.btg.test.util.Keyboard
import br.com.btg.test.R
import kotlinx.android.synthetic.main.fragment_currency_layout.*
import org.koin.android.viewmodel.ext.android.viewModel
import java.math.RoundingMode
import java.text.DecimalFormat

class CurrencyFragment : BaseFragment() {

    companion object {
        const val REQUEST_SOURCE_CURRENCY = 1001
        const val REQUEST_TARGET_CURRENCY = 1002

        fun newInstance() =
            CurrencyFragment()
    }

    private val viewModel by viewModel<CurrencyViewModel>()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        return inflater.inflate(R.layout.fragment_currency_layout, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        configureObserver()
        configureComponents()

        configureConvertButton()
    }

    private fun configureConvertButton() {
        btnConvert.setOnClickListener {
            Keyboard.hideKeyboard(requireContext(), it)
            try {
                val value = convertValue.text.toString().toDouble()
                viewModel.convert(value)
            } catch (e: Exception) {
                showError(e.message, snack_bar)
            }
        }
    }

    private fun configureComponents() {
        sourceCurrency.keyListener = null
        targetCurrency.keyListener = null

        sourceCurrency.setOnClickListener {
            CurrenciesListActivity.startWithRequestCode(
                this@CurrencyFragment,
                REQUEST_SOURCE_CURRENCY
            )
        }

        targetCurrency.setOnClickListener {
            CurrenciesListActivity.startWithRequestCode(
                this@CurrencyFragment,
                REQUEST_TARGET_CURRENCY
            )
        }
    }

    private fun configureObserver() {
        viewModel.convertResult.observe(requireActivity(), Observer {
            when (it.status) {
                Status.SUCCESS -> showResult(it.data)
                Status.ERROR -> showError(it.message, snack_bar)
            }
        })

    }

    private fun showResult(value: Double?) {
        val df = DecimalFormat("#####.##")
        df.roundingMode = RoundingMode.CEILING
        convertValue.setText(df.format(value))
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        when (requestCode) {
            REQUEST_SOURCE_CURRENCY -> {
                var currency = data?.getParcelableExtra<CurrencyEntity>(
                    CurrenciesListFragment.CURRENCY_EXTRA_RESULT
                )

                currency?.let {
                    sourceCurrency.setText(
                        it.code
                    )
                    viewModel.sourceCurrencyEntity = it
                }
            }

            REQUEST_TARGET_CURRENCY -> {
                var currency = data?.getParcelableExtra<CurrencyEntity>(
                    CurrenciesListFragment.CURRENCY_EXTRA_RESULT
                )

                currency?.let {
                    targetCurrency.setText(
                        it.code
                    )
                    viewModel.targetCurrencyEntity = it
                }
            }
        }
    }
}