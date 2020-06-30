package br.com.daccandido.currencyconverterapp.ui.splashscreen

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import androidx.lifecycle.Observer
import br.com.daccandido.currencyconverterapp.R
import br.com.daccandido.currencyconverterapp.data.database.CurrencyDAO
import br.com.daccandido.currencyconverterapp.data.repository.CurrencyData
import br.com.daccandido.currencyconverterapp.prefs
import br.com.daccandido.currencyconverterapp.ui.convertcurrency.ConvertCurresncyActivity
import br.com.daccandido.currencyconverterapp.utils.isInternetAvailable
import kotlinx.android.synthetic.main.activity_splash_screen.*

class SplashScreenActivity : AppCompatActivity() {

    private lateinit var viewModel: SplashScreenViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash_screen)

        viewModel = SplashScreenViewModel
            .ViewModelFactory(CurrencyData(), CurrencyDAO())
            .create(SplashScreenViewModel::class.java)

        setUpObserve()

        if (prefs.isDownloadingInfo.not()) {
            if (isInternetAvailable()) {
                loadingInfo()
            } else {
                viewModel.isLoading.value = false
                tvError?.text = getString(R.string.not_internet)
            }
        } else {
            callActivity()
        }

    }

    private fun setUpObserve () {
        viewModel.isLoading.observe(this, Observer {
            if (it) {
                tvError.visibility = View.GONE
                progressBar.visibility = View.VISIBLE
            } else {
                progressBar.visibility = View.GONE
            }
        })
    }

    private fun loadingInfo () {

        viewModel.getInfo { error, isSuccess ->
            error?.let {
                tvError.visibility = View.VISIBLE
                tvError?.text = getString(it)
            } ?: run {
                if (isSuccess) {
                    prefs.isDownloadingInfo = true
                    callActivity()
                }  else {
                    tvError.visibility = View.VISIBLE
                    tvError?.text = getString(R.string.error)
                }
            }
        }
    }

    private fun callActivity() {
        Intent(this@SplashScreenActivity, ConvertCurresncyActivity::class.java).apply {
            startActivity(this)
            finish()
        }
    }
}
