package com.btgpactual.currencyconverter.ui.activity

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.observe
import com.btgpactual.currencyconverter.R
import com.btgpactual.currencyconverter.data.framework.retrofit.NetworkConnectionInterceptor
import com.btgpactual.currencyconverter.data.framework.retrofit.repository.CurrencyRetrofit
import com.btgpactual.currencyconverter.data.framework.roomdatabase.AppDatabase
import com.btgpactual.currencyconverter.data.framework.roomdatabase.dao.CurrencyDAO
import com.btgpactual.currencyconverter.data.framework.roomdatabase.repository.CurrencyRoomDatabase
import com.btgpactual.currencyconverter.data.repository.CurrencyInternalRepository
import com.btgpactual.currencyconverter.ui.viewmodel.OpeningViewModel
import com.btgpactual.currencyconverter.ui.viewmodel.OpeningViewModel.CurrencyModelListState.FailedUpdate.NoInternetConnection

class OpeningActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_opening)

        val currencyDAO: CurrencyDAO =
            AppDatabase.getInstance(this).currencyDAO

        val repository: CurrencyInternalRepository = CurrencyRoomDatabase(currencyDAO)

        val viewModel : OpeningViewModel = OpeningViewModel.ViewModelFactory(CurrencyRetrofit(),repository)
            .create(OpeningViewModel::class.java)

        val networkConnectionInterceptor = NetworkConnectionInterceptor(this)

        viewModel.currencyModelListStateEventData.observe(this) { currencyListState ->
            when (currencyListState) {
                is OpeningViewModel.CurrencyModelListState.SuccessfulUpdate -> {
                    redirectToCurrencyActivity()
                }
                is OpeningViewModel.CurrencyModelListState.FailedUpdate.FailedRequest, is NoInternetConnection -> {
                    val existentList = when (currencyListState) {
                        is NoInternetConnection -> {
                            currencyListState.existentList
                        }
                        is OpeningViewModel.CurrencyModelListState.FailedUpdate.FailedRequest -> {
                            currencyListState.existentList
                        }
                        else -> false
                    }

                    val message: String = when (currencyListState) {
                        is NoInternetConnection -> {
                            if (existentList) {
                                getString(R.string.opening_view_model_error_no_internet_connection_allow_continue)
                            } else {
                                getString(R.string.opening_view_model_error_no_internet_connection_block_continue)
                            }
                        }
                        is OpeningViewModel.CurrencyModelListState.FailedUpdate.FailedRequest -> {
                            if (existentList) {
                                getString(R.string.opening_view_model_error_request_allow_continue)
                            } else {
                                getString(R.string.opening_view_model_error_request_block_continue)
                            }
                        }
                        else -> ""
                    }

                    if(message.isBlank()) return@observe

                    val builder = AlertDialog.Builder(this)
                    builder.setTitle(getString(R.string.opening_activity_dialog_title_generic))
                    builder.setMessage(message)
                    builder.setCancelable(false)

                    if(existentList){
                        builder.setPositiveButton(getString(R.string.button_continue)) { dialog, which ->
                            redirectToCurrencyActivity()
                        }

                        builder.setNeutralButton(getString(R.string.button_try_again)) { dialog, which ->
                            viewModel.updateCurrencyModelList(NetworkConnectionInterceptor(this))
                        }
                    }else{
                        builder.setPositiveButton(getString(R.string.button_try_again)) { dialog, which ->
                            viewModel.updateCurrencyModelList(NetworkConnectionInterceptor(this))
                        }

                        builder.setNegativeButton(getString(R.string.button_cancel)) { dialog, which ->
                            finish()
                        }
                    }

                    builder.show()
                }
            }
        }

        viewModel.updateCurrencyModelList(networkConnectionInterceptor)

    }

    private fun redirectToCurrencyActivity(){
        val intent = Intent(this, CurrencyActivity::class.java)
        intent.flags =
            Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        startActivity(intent)
    }

}