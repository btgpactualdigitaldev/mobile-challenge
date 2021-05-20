package br.com.albertomagalhaes.btgcurrencies.activity

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.observe
import br.com.albertomagalhaes.btgcurrencies.R
import br.com.albertomagalhaes.btgcurrencies.extension.showSimpleDialog
import br.com.albertomagalhaes.btgcurrencies.viewmodel.SetupViewModel
import com.btgpactual.currencyconverter.data.framework.retrofit.ClientAPI
import org.koin.androidx.viewmodel.ext.android.viewModel

class SplashActivity : AppCompatActivity() {

    val setupViewModel: SetupViewModel by viewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        setupViewModel.synchronizeCurrencyListStatus.observe(this) { value ->
            when(value){
                is ClientAPI.ResponseType.Success<*> -> redirectToMain()
                is ClientAPI.ResponseType.Fail.NoInternet -> handleSynchronizationError(value)
                is ClientAPI.ResponseType.Fail.Unknown -> handleSynchronizationError(value)
            }
        }

        setupViewModel.synchronizeCurrencyList()
    }

    fun handleSynchronizationError(failType:ClientAPI.ResponseType.Fail){
        setupViewModel.hasCurrencyList {
            if(it){
                redirectToMain()
            }else{
                showSimpleDialog(
                    title = getString(R.string.alert),
                    message = when(failType){
                        is ClientAPI.ResponseType.Fail.NoInternet -> getString(R.string.no_internet_message)
                        is ClientAPI.ResponseType.Fail.Unknown -> getString(R.string.service_unavailable_message)
                    },
                    primaryButtonName = getString(R.string.try_again),
                    primaryAction = { setupViewModel.synchronizeCurrencyList() },
                    secondaryButtonName = getString(R.string.exit),
                    secondaryAction = { finish() }
                )
            }
        }
    }

    fun redirectToMain() {
        val intent = Intent(this, MainActivity::class.java)
        intent.flags =
            Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        startActivity(intent)
    }
}