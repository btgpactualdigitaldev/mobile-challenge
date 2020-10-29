package br.com.andreldsr.btgcurrencyconverter.presenter.ui.opening

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import androidx.lifecycle.observe
import br.com.andreldsr.btgcurrencyconverter.R
import br.com.andreldsr.btgcurrencyconverter.presenter.ui.currency.CurrencyActivity
import br.com.andreldsr.btgcurrencyconverter.presenter.viewmodel.SplashViewModel
import br.com.andreldsr.btgcurrencyconverter.util.ConnectionUtil
import kotlinx.android.synthetic.main.activity_splash.*

class SplashActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        ConnectionUtil.initConnectionUtil(this)

        val viewModel: SplashViewModel by viewModels {
            SplashViewModel.ViewModelFactory()
        }

        viewModel.initCurrencyData()

        viewModel.splashState.observe(this) {
            when (it) {
                is SplashViewModel.SplashState.internetErrorFirstAccessSplashState -> errorLoading()
                is SplashViewModel.SplashState.loadFromAPISplashState -> loadedFromApi()
                is SplashViewModel.SplashState.loadFromDatabaseSplashState -> loadedFromBD()
            }
        }

    }

    private fun errorLoading() {
        splashErrorText.text = getString(R.string.splash_error_message)
    }

    private fun loadedFromApi() {
        redirectToCurrencyActivity()
    }
    private fun loadedFromBD() {
        redirectToCurrencyActivity()
    }

    private fun redirectToCurrencyActivity(){
        val intent = Intent(this, CurrencyActivity::class.java)
        intent.flags =
            Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        startActivity(intent)
    }

}