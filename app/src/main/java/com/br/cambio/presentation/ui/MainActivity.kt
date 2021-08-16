package com.br.cambio.presentation.ui

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkInfo
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.br.cambio.R
import com.br.cambio.customviews.DialogSpinnerModel
import com.br.cambio.databinding.ActivityMainBinding
import com.br.cambio.presentation.viewmodel.MainViewModel
import com.br.cambio.utils.subscribe
import org.koin.androidx.viewmodel.ext.android.viewModel

class MainActivity : AppCompatActivity(R.layout.activity_main) {
    private val viewModel: MainViewModel by viewModel()
    private lateinit var currencies: List<DialogSpinnerModel>
    private val viewBinding by lazy {
        ActivityMainBinding.inflate(layoutInflater)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(viewBinding.root)
        subscribeEvents()
        viewModel.getCurrency(checkNetwork())

        viewBinding.EditTextMonetaryBrazil.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                viewModel.calculateResult(
                    viewBinding.spFirst.textKey,
                    viewBinding.spSecond.textKey,
                    viewBinding.EditTextMonetaryBrazil.text.toString().toDoubleOrNull()
                )
            }
        })
    }

    private fun checkNetwork(): Boolean {
        val cm = this.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetwork: NetworkInfo? = cm.activeNetworkInfo

        return activeNetwork?.isConnectedOrConnecting == true
    }

    private fun setResultView(valor: Double) {
        viewBinding.tvResult.text = "$ $valor"
        viewBinding.clResult.visibility = View.VISIBLE
    }

    private fun subscribeEvents() {
        viewModel.successCurrencyEvent.subscribe(this) {
            currencies = this.data.sortedBy { it.nome }.toList()
            viewModel.getPrice(checkNetwork())
        }

        viewModel.successPriceEvent.subscribe(this) {
            setVisibility()
        }

        viewModel.emptyResponseEvent.subscribe(this) {
            viewBinding.loading.hideLoading()
        }

        viewModel.errorResponseEvent.subscribe(this) {
            viewBinding.loading.hideLoading()
        }

        viewModel.successResultEvent.subscribe(this) {
            setResultView(this.data)
        }
    }

    private fun setVisibility() {
        viewBinding.loading.hideLoading()
        viewBinding.EditTextMonetaryBrazil.visibility = View.VISIBLE
        viewBinding.spFirst.setCustomSpinnerList(currencies)
        viewBinding.spFirst.visibility = View.VISIBLE
        viewBinding.spSecond.setCustomSpinnerList(currencies)
        viewBinding.spSecond.visibility = View.VISIBLE
    }
}