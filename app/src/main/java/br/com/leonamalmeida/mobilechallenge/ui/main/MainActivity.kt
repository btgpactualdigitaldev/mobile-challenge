package br.com.leonamalmeida.mobilechallenge.ui.main

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.core.widget.doOnTextChanged
import androidx.lifecycle.Observer
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.ui.currency.CurrencyActivity
import br.com.leonamalmeida.mobilechallenge.util.EXTRA_CURRENCY
import br.com.leonamalmeida.mobilechallenge.util.haveNetwork
import br.com.leonamalmeida.mobilechallenge.util.snack
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.android.synthetic.main.activity_main.*

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {

    private val viewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setToolbar()
        setListeners()
        setObservers()
        mainSr.isEnabled = false
    }

    private fun setToolbar() {
        setSupportActionBar(toolbar)
        title = getString(R.string.activity_main_title)
    }

    private fun setListeners() {
        originTv.setOnClickListener { viewModel.onOriginClick() }
        destinyTv.setOnClickListener { viewModel.onDestinyClick() }
        convertBtn.setOnClickListener { viewModel.convert(amountTv.text.toString()) }

        amountTv.doOnTextChanged { text, _, _, _ ->
            convertBtn.isEnabled = !text.isNullOrBlank()
            if (text.isNullOrBlank()) displayResultValue(false)
        }
    }

    private fun setObservers() {
        viewModel.run {
            originCurrency.observe(this@MainActivity, Observer {
                originTv.text = it
                displayResultValue(false)
            })

            destinyCurrency.observe(this@MainActivity, Observer {
                destinyTv.text = it
                displayResultValue(false)
            })

            displayAmountField.observe(this@MainActivity, Observer {
                displayAmount(it)
                convertBtn.visibility = if (it) View.VISIBLE else View.GONE
            })

            resultValue.observe(this@MainActivity, Observer {
                lastUpdateTv.text = getString(R.string.last_update, it.first)
                resultValueTv.text = it.second
                displayResultValue(true)
            })

            openCurrencyActivity.observe(this@MainActivity, Observer { requestCode ->
                startActivityForResult(
                    Intent(baseContext, CurrencyActivity::class.java),
                    requestCode
                )
            })

            loading.observe(this@MainActivity, Observer { displayLoading(it) })

            error.observe(this@MainActivity, Observer { displayError(it) })
        }
    }

    private fun displayLoading(it: Boolean) {
        mainSr.isEnabled = it
        mainSr.isRefreshing = it
    }

    private fun displayError(msgRes: Int) {
        snack(
            mainRoot,
            if (haveNetwork()) msgRes else R.string.no_connection_error,
            R.string.action_reload
        ) { convertBtn.performClick() }
    }

    private fun displayResultValue(display: Boolean) {
        lastUpdateTv.visibility = if (display) View.VISIBLE else View.GONE
        resultValueLabelTv.visibility = if (display) View.VISIBLE else View.GONE
        resultValueCv.visibility = if (display) View.VISIBLE else View.GONE
    }

    private fun displayAmount(display: Boolean) {
        amountLabelTv.visibility = if (display) View.VISIBLE else View.GONE
        amountCv.visibility = if (display) View.VISIBLE else View.GONE
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK)
            viewModel.handleCurrencySelection(requestCode, data?.getStringExtra(EXTRA_CURRENCY))
    }
}