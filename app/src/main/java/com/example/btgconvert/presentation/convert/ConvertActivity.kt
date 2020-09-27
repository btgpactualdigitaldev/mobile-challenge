package com.example.btgconvert.presentation.convert

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.example.btgconvert.R
import com.example.btgconvert.presentation.base.BaseActivity
import com.example.btgconvert.presentation.currencyList.CurrencyListActivity
import kotlinx.android.synthetic.main.activity_convert.*
import kotlinx.android.synthetic.main.include_toolbar.*


class ConvertActivity : BaseActivity() {
    lateinit var viewModel: ConvertViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_convert)

        setToolbar(toolbar, R.string.convertTitle, false)
        viewModel = ViewModelProviders.of(this).get(ConvertViewModel::class.java)
        listener()
        observer()
        viewModel.startApp(this)


    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK) {
            if (requestCode == 1) {
                if (data != null) {
                    buttonFrom.text = data.getStringExtra("selectedCurrency")
                }
            }
            if (requestCode == 2) {
                if (data != null) {
                    buttonTo.text = data.getStringExtra("selectedCurrency")
                }
            }
            tryConvert()
        }
    }

    private fun listener() {
        buttonFrom.setOnClickListener {
            this.startActivityForResult(CurrencyListActivity.getStartIntent(this), 1)
        }
        buttonTo.setOnClickListener {
            this.startActivityForResult(CurrencyListActivity.getStartIntent(this), 2)
        }
        desiredValue.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable) {}
            override fun beforeTextChanged(s: CharSequence, start: Int,
                                           count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence, start: Int,
                                       before: Int, count: Int) {
                tryConvert()
            }
        })
    }

    private fun observer() {
        viewModel.currencyListLiveData.observe(this, Observer {
            it?.let {
                viewModel.saveData(it, this)
            }
        })

        viewModel.quoteLiveData.observe(this, Observer {
            it?.let {
                viewModel.getCurrency(it)
            }
        })

        viewModel.convertLiveData.observe(this, Observer {
            it?.let {
                convertedValue.text = it.first
                convertDescription.text = it.second

            }
        })

        viewModel.flipperLiveData.observe(this, Observer {
            flipperHome.displayedChild = it
        })

        viewModel.offlineLiveData.observe(this, Observer {
            if (it) {
                offlineWarning.visibility = View.VISIBLE
            } else {
                offlineWarning.visibility = View.GONE
            }

        })
    }

    private fun tryConvert() {
        if (!desiredValue.text.isNullOrEmpty()) {
            if (buttonTo.text.toString() != getString(R.string.select) && buttonFrom.text.toString() != getString(R.string.select) && desiredValue.text.toString().toDouble() > 0) {
                viewModel.convert(this, buttonTo.text.toString(), buttonFrom.text.toString(), desiredValue.text.toString().toDouble())
                return
            }
        }
        convertDescription.text = ""
        convertedValue.text = getString(R.string.zero)
    }

    companion object{
        private const val FROM = "from"
        private const val TO = "to"
        private const val DESIRED_VALUE = "desiredValue"
    }
}