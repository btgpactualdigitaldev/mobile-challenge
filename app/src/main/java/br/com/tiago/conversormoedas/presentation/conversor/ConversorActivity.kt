package br.com.tiago.conversormoedas.presentation.conversor

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.view.inputmethod.InputMethodManager
import android.widget.Toast
import androidx.core.content.ContextCompat
import androidx.lifecycle.Observer
import br.com.tiago.conversormoedas.R
import br.com.tiago.conversormoedas.data.respository.ConversorApiDataSource
import br.com.tiago.conversormoedas.presentation.coins.CoinsActivity
import br.com.tiago.conversormoedas.presentation.data.BaseActivity
import kotlinx.android.synthetic.main.activity_conversion.*
import kotlinx.android.synthetic.main.include_toolbar.*

class ConversorActivity : BaseActivity() {

    private var coinOrigin: String? = null
    private var coinDestiny: String? = null
    private var rateOrigin = 0F
    private var rateDestiny = 0F

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_conversion)

        setupToolbar(toolbarMain, R.string.conversion_title)

        val viewModel: ConversorViewModel =
            ConversorViewModel.ViewModelFactory(ConversorApiDataSource())
                .create(ConversorViewModel::class.java)

        cardOrigin.setOnClickListener {
            val intent = CoinsActivity.getStartIntent(this@ConversorActivity)
            this@ConversorActivity.startActivityForResult(intent, 1)
        }

        cardDestiny.setOnClickListener {
            val intent = CoinsActivity.getStartIntent(this@ConversorActivity)
            this@ConversorActivity.startActivityForResult(intent, 2)
        }

        viewModel.conversionLiveDataOrigin.observe(this, Observer {
            it?.let { conversion ->
                rateOrigin = conversion
                viewModel.getRates(coinDestiny!!, RATE_DESTINY)
            }
        })

        viewModel.conversionLiveDataDestiny.observe(this, Observer {
            it?.let { conversion ->
                val inputMethodManager = getSystemService(Activity.INPUT_METHOD_SERVICE) as InputMethodManager
                inputMethodManager.hideSoftInputFromWindow(btnConversion.windowToken, 0)

                rateDestiny = conversion
                val value: Float = edtValue.text.toString().toFloat()

                viewModel.calculateValue(rateOrigin, rateDestiny, value)
            }
        })

        viewModel.conversionLiveDataResult.observe(this, Observer {
            it?.let { conversion ->
                carResult.visibility = View.VISIBLE
                txtResultOrigin.text = coinOrigin
                txtResultDestiny.text = coinDestiny

                txtValue.text = resources.getString(R.string.result, conversion)
            }
        })

        viewModel.validateLiveDataResult.observe(this, Observer {
            it.let {result ->
                if (result != null){
                    Toast.makeText(this@ConversorActivity, result, Toast.LENGTH_SHORT).show()
                } else {
                    viewModel.getRates(coinOrigin!!, RATE_ORIGIN)
                }
            }
        })

        viewModel.toastLiveDataResult.observe(this, Observer {
            it.let { result ->
                if (result != null) {
                    Toast.makeText(this@ConversorActivity, resources.getString(result), Toast.LENGTH_SHORT).show()
                }
            }
        })

        viewModel.changeColorOrigin.observe(this, Observer {
            it?.let { result->
                if (result) {
                    cardOrigin.setCardBackgroundColor(ContextCompat.getColor(this@ConversorActivity, R.color.colorAccent))
                } else {
                    cardOrigin.setCardBackgroundColor(ContextCompat.getColor(this@ConversorActivity, R.color.colorPrimary))
                }
            }
        })

        viewModel.changeColorDestiny.observe(this, Observer {
            it?.let { result->
                if (result) {
                    cardDestiny.setCardBackgroundColor(ContextCompat.getColor(this@ConversorActivity, R.color.colorAccent))
                } else {
                    cardDestiny.setCardBackgroundColor(ContextCompat.getColor(this@ConversorActivity, R.color.colorPrimary))
                }
            }
        })

        viewModel.changeColorValue.observe(this, Observer {
            it?.let { result->
                if (result) {
                    edtValue.background = ContextCompat.getDrawable(this@ConversorActivity, R.drawable.shape_edittext_error)
                } else {
                    edtValue.background = ContextCompat.getDrawable(this@ConversorActivity, R.drawable.shape_edittext)
                }
            }
        })

        btnConversion.setOnClickListener {
            viewModel.validateFields(this@ConversorActivity, coinOrigin, coinDestiny, edtValue.text.toString())
        }

        edtValue.setOnFocusChangeListener { _, _ ->
            edtValue.background = ContextCompat.getDrawable(this@ConversorActivity, R.drawable.shape_edittext)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 1){
            if (resultCode == Activity.RESULT_OK){
                val initials = data!!.getStringExtra("initials")
                populateOrigin(initials = initials)
            }
        }
        if (requestCode == 2){
            if (resultCode == Activity.RESULT_OK) {
                val initials = data!!.getStringExtra("initials")
                populateDestiny(initials = initials)
            }
        }
    }

    private fun populateOrigin(initials: String?){
        if (initials != null) {
            coinOrigin = initials
            txtInitialsOrigin.text = initials
            imgCoinOrigin.visibility = View.VISIBLE
            txtInitialsOrigin.visibility = View.VISIBLE
            txtSelectCoinOrigin.visibility = View.GONE
            cardOrigin.setCardBackgroundColor(ContextCompat.getColor(this@ConversorActivity, R.color.colorPrimary))
        } else {
            coinOrigin = null
            imgCoinOrigin.visibility = View.GONE
            txtInitialsOrigin.visibility = View.GONE
            txtSelectCoinOrigin.visibility = View.VISIBLE
        }
    }

    private fun populateDestiny(initials: String?){
        if (initials != null) {
            coinDestiny = initials
            txtInitialsDestiny.text = initials
            imgCoinDestiny.visibility = View.VISIBLE
            txtInitialsDestiny.visibility = View.VISIBLE
            txtSelectCoinDestiny.visibility = View.GONE
            cardDestiny.setCardBackgroundColor(ContextCompat.getColor(this@ConversorActivity, R.color.colorPrimary))
        } else {
            coinDestiny = null
            imgCoinDestiny.visibility = View.GONE
            txtInitialsDestiny.visibility = View.GONE
            txtSelectCoinDestiny.visibility = View.VISIBLE
        }
    }

    companion object{
        private const val RATE_ORIGIN = 1
        private const val RATE_DESTINY = 2
    }
}