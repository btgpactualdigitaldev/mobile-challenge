package com.btgpactual.teste.mobile_challenge.ui.loading

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.ProgressBar
import android.widget.TextView
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import com.btgpactual.teste.mobile_challenge.R
import com.btgpactual.teste.mobile_challenge.data.remote.Status
import com.btgpactual.teste.mobile_challenge.databinding.ActivityLoadingBinding
import com.btgpactual.teste.mobile_challenge.ui.main.MainActivity
import com.btgpactual.teste.mobile_challenge.util.Connection
import com.btgpactual.teste.mobile_challenge.util.ViewModelProviderFactory
import dagger.android.support.DaggerAppCompatActivity
import javax.inject.Inject


class LoadingActivity : DaggerAppCompatActivity() {

    private val TAG = "LoadingActivity"

    private lateinit var pbLoading: ProgressBar

    private lateinit var txtLoading: TextView

    lateinit var loadingViewModel: LoadingViewModel

    private var loading = true

    @Inject
    lateinit var providerFactory: ViewModelProviderFactory

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val binding = DataBindingUtil.setContentView<ActivityLoadingBinding>(
            this,
            R.layout.activity_loading
        )

        loadingViewModel = ViewModelProvider(this, providerFactory).get(LoadingViewModel::class.java)

        subscribeObserver()

        pbLoading = binding.pbLoading

        txtLoading = binding.txtLoading

    }

    private fun subscribeObserver() {
        loadingViewModel.observeSyncAll().removeObservers(this)
        loadingViewModel.observeSyncAll().observe(this, {
            when (it?.status) {
                Status.LOADING -> {
                    Log.d(TAG, "subscribeObserver: Carregando")
                }
                Status.ERROR -> {
                    Log.d(TAG, "subscribeObserver: Erro ${it.message} - ${it.data.toString()}")
                    errorMessage(it.message ?: getString(R.string.error_loading))
                }
                Status.SUCCESS -> {
                    Log.d(TAG, "subscribeObserver: Sucesso ${it.data}")
                    onLoadSuccess()
                }
            }
        })

        loadingViewModel.getCurrencyList()?.removeObservers(this)
        loadingViewModel.getCurrencyList()?.observe(this, {
            val internet = Connection.hasInternet(this)
            Log.d(TAG, "subscribeObserver: Verificando internet $internet")
            Log.d(TAG, "subscribeObserver: Verificou DB")
            if (loading) {
                when {
                    internet -> {
                        loading = false
                        Log.d(TAG, "subscribeObserver: Executando loading das informações")
                        loadingViewModel.sync()
                    }
                    it.isNullOrEmpty() -> {
                        loading = false
                        errorMessage(getString(R.string.error_loading))
                        Log.d(TAG, "subscribeObserver: Verificou DB - Sem Dados")
                    }
                    else -> {
                        loading = false
                        Log.d(TAG, "subscribeObserver: Carregou sem internet")
                        onLoadSuccess()
                    }
                }
            }
        })
    }

    private fun onLoadSuccess() {
        startActivity(Intent(this, MainActivity::class.java))
        finish()
    }

    fun errorMessage(msg: String) {
        pbLoading.visibility = View.GONE
        txtLoading.text = msg
    }
}