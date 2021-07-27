package com.hotmail.fignunes.btg.presentation.quotedollar

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.view.inputmethod.InputMethodManager
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import com.hotmail.fignunes.btg.R
import com.hotmail.fignunes.btg.common.BaseActivity
import com.hotmail.fignunes.btg.common.ToastCustom
import com.hotmail.fignunes.btg.databinding.ActivityQuoteDollarBinding
import com.hotmail.fignunes.btg.model.ChooseCurrency
import com.hotmail.fignunes.btg.presentation.currencies.CurrenciesActivity
import kotlinx.android.synthetic.main.activity_quote_dollar.*
import org.jetbrains.anko.startActivityForResult
import org.koin.android.ext.android.inject
import org.koin.core.parameter.parametersOf

class QuoteDollarActivity : BaseActivity(), QuoteDollarContract{
    companion object {
        const val CHOOSE_CURRENCY = "choose_currency"
        const val CURRENCY = "currency"
    }

    private val presenter: QuoteDollarPresenter by inject{ parametersOf(this) }
    private lateinit var binding : ActivityQuoteDollarBinding

    private val REQUEST_CODE_CURRENCIES = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = DataBindingUtil.setContentView(this, R.layout.activity_quote_dollar)
        binding.presenter = presenter
        presenter.onCreate()
        backButton()
    }

    override fun source() {
        startActivityForResult<CurrenciesActivity>(REQUEST_CODE_CURRENCIES, CHOOSE_CURRENCY to ChooseCurrency.SOURCE.toString())
    }

    override fun destiny() {
        startActivityForResult<CurrenciesActivity>(REQUEST_CODE_CURRENCIES, CHOOSE_CURRENCY to ChooseCurrency.DESTINY.toString())
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.menu_quote_dollar, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            android.R.id.home -> finish()
            R.id.menu_eraser -> presenter.clear()
        }
        return super.onOptionsItemSelected(item)
    }

    override fun message(error: String) {
        ToastCustom.execute(this, error)
    }

    override fun hideKeyboard() {
        if (this.currentFocus != null) {
            val imm = this.getSystemService(AppCompatActivity.INPUT_METHOD_SERVICE) as InputMethodManager
            imm.hideSoftInputFromWindow(this.currentFocus!!.windowToken, 0)
        }
    }

    override fun progressbar(visible: Boolean) {
        if(visible) {
            quoteDollarProgressBar.visibility = View.VISIBLE
            quoteDollarConvertCurrencies.visibility = View.GONE

        } else {
            quoteDollarProgressBar.visibility = View.GONE
            quoteDollarConvertCurrencies.visibility = View.VISIBLE
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        when(requestCode) {
            REQUEST_CODE_CURRENCIES -> {
                if (resultCode == Activity.RESULT_OK && data != null)  {
                    presenter.chooseCurrency(data)
                }
            }
        }
    }

    override fun onDestroy() {
        presenter.dispose()
        super.onDestroy()
    }
}