package com.btg.conversormonetario.view.viewmodel

import android.app.Application
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.btg.conversormonetario.App
import com.btg.conversormonetario.R
import com.btg.conversormonetario.business.database.DataManager
import com.btg.conversormonetario.data.dto.AlertDialogDTO
import com.btg.conversormonetario.data.dto.ErrorRepositoryDTO
import com.btg.conversormonetario.data.model.ErrorModel
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import com.btg.conversormonetario.data.model.ServiceErrorModel
import com.btg.conversormonetario.shared.warningDialog
import com.github.pwittchen.reactivenetwork.library.rx2.ReactiveNetwork
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.rxkotlin.addTo
import io.reactivex.schedulers.Schedulers
import kotlinx.coroutines.CoroutineExceptionHandler

open class BaseViewModel(dataManager: DataManager, application: Application) :
    AndroidViewModel(application) {

    companion object {
        const val CURRENCY_KEY = "CURRENCY_KEY"
        const val CURRENCY_ORIGIN = "CURRENCY_ORIGIN"
        const val CURRENCY_TARGET = "CURRENCY_TARGET"
    }

    protected var currentContext = MutableLiveData<AppCompatActivity>()
    var originalCurrenciesSingleton = MutableLiveData<ArrayList<InfoCurrencyModel.DTO>>()
    var appHasInternet = MutableLiveData<Boolean>()
    var showLoader = MutableLiveData<Boolean>()

    protected val webServiceException = CoroutineExceptionHandler { _, exception ->
        Log.v(
            "LOG",
            "webServiceException: CAUSE: ${exception.cause} | exception: MESSAGE: ${exception.message} | exception: STACKTRACE: ${exception.stackTrace} | "
        )
        onErrorResponse(
            currentContext.value!!,
            ErrorRepositoryDTO(
                serviceErrorModel = ServiceErrorModel(
                    response = ErrorModel(
                        400,
                        exception.message
                            ?: currentContext.value!!.getString(R.string.alert_message_generic)
                    )
                ),
                alertDTO = AlertDialogDTO(
                    R.string.alert_title_dados_invalidos,
                    exception.message
                        ?: currentContext.value!!.getString(R.string.alert_message_generic),
                    R.string.all_understood
                ) { }
            )
        )
    }

    open fun initViewModel() {
        originalCurrenciesSingleton.value = App.getInfoCurrencyData()?.currencies
    }

    fun showLoading() {
        showLoader.postValue(true)
    }

    fun hideLoading() {
        showLoader.postValue(false)
    }

    fun startConnectionListener() {
        ReactiveNetwork
            .observeInternetConnectivity()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe(
                { isConnectedToInternet ->
                    appHasInternet.value = isConnectedToInternet            // for snackbar
                    App.getInstance().hasInternet = isConnectedToInternet   // for all app
                },
                {
                    appHasInternet.value = false                            // for snackbar
                    App.getInstance().hasInternet = false                   // for all app
                }
            ).addTo(CompositeDisposable())
    }

    fun setContext(ctx: AppCompatActivity) {
        currentContext.value = ctx
    }

    protected fun getCurrencyNameByCode(code: String): String {
        for (item in originalCurrenciesSingleton.value ?: arrayListOf()) {
            if (item.code == code) {
                return item.name ?: currentContext.value!!.getString(R.string.selecione)
            }
        }
        return currentContext.value!!.getString(R.string.selecione)
    }

    fun getCurrencyIconByCode(code: String): Int? {
        return when (code) {
            "AFN" -> return R.drawable.afghanistan_flag
            "ALL" -> return R.drawable.albania_flag
            "AMD" -> return R.drawable.armenia_flag
            "AOA" -> return R.drawable.angola_flag
            "ARS" -> return R.drawable.argentina_flag
            "AUD" -> return R.drawable.australia_flag
            "BDT" -> return R.drawable.bangladesh_flag
            "BRL" -> return R.drawable.brazil_flag
            "BTC" -> return R.drawable.bitcoin_flag
            "CAD" -> return R.drawable.canada_flag
            "CNY" -> return R.drawable.china_flag
            "COP" -> return R.drawable.colombia_flag
            "CUP" -> return R.drawable.cuba_flag
            "CUC" -> return R.drawable.cuba_flag
            "EGP" -> return R.drawable.egypt_flag
            "EUR" -> return R.drawable.european_union_flag
            "FJD" -> return R.drawable.fiji_flag
            "HKD" -> return R.drawable.hong_kong_flag
            "INR" -> return R.drawable.india_flag
            "IDR" -> return R.drawable.indonesia_flag
            "ILS" -> return R.drawable.israel_flag
            "JMD" -> return R.drawable.jamaica_flag
            "JPY" -> return R.drawable.japan_flag
            "KWD" -> return R.drawable.kuwait_flag
            "MXN" -> return R.drawable.mexico_flag
            "NPR" -> return R.drawable.nepal_flag
            "NZD" -> return R.drawable.new_zealand_flag
            "KPW" -> return R.drawable.north_korea_flag
            "PYG" -> return R.drawable.paraguay_flag
            "PEN" -> return R.drawable.peru_flag
            "QAR" -> return R.drawable.qatar_flag
            "RUB" -> return R.drawable.russia_flag
            "SGD" -> return R.drawable.singapore_flag
            "ZAR" -> return R.drawable.south_africa_flag
            "KRW" -> return R.drawable.south_korea_flag
            "SEK" -> return R.drawable.sweden_flag
            "TRY" -> return R.drawable.turkey_flag
            "AED" -> return R.drawable.united_arab_emirates_flag
            "GBP" -> return R.drawable.united_kingdom_flag
            "USD" -> return R.drawable.united_states_flag
            "UYU" -> return R.drawable.uruguay_flag
            else -> null
        }
    }

    fun onErrorResponse(ctx: AppCompatActivity, errorDTO: ErrorRepositoryDTO) {
        hideLoading()
        Log.v("LOG", "erro: ${errorDTO.serviceErrorModel?.httpCode}")
        warningDialog(
            ctx,
            ctx.getString(R.string.alert_title_400),
            errorDTO.serviceErrorModel?.response?.info
                ?: ctx.getString(R.string.alert_message_generic),
            ctx.getString(R.string.alert_textpositivebutton_401)
        ) {}
    }

    protected fun navigateTo(clazzToGo: Class<*>, bundle: Bundle? = null) {
        currentContext.value!!.startActivity(Intent(currentContext.value!!, clazzToGo).apply {
            if (bundle != null)
                putExtras(bundle)
        })
    }

    protected fun backTo(clazzToGo: Class<*>, bundle: Bundle? = null) {
        currentContext.value!!.finish()
        currentContext.value!!.startActivity(Intent(currentContext.value!!, clazzToGo).apply {
            if (bundle != null)
                putExtras(bundle)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK)
        })
    }

}