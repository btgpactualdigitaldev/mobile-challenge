package com.hotmail.fignunes.btg.presentation.currencies

import com.hotmail.fignunes.btg.R
import com.hotmail.fignunes.btg.common.BasePresenter
import com.hotmail.fignunes.btg.common.StringHelper
import com.hotmail.fignunes.btg.model.ChooseCurrency
import com.hotmail.fignunes.btg.presentation.currencies.actions.GetCurrenciesLocal
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

class CurrenciesPresenter(
    private val contract: CurrenciesContract,
    private val getCurrenciesLocal: GetCurrenciesLocal,
    private val stringHelper: StringHelper
) : BasePresenter() {

    var chooseCurrency: String = ""
    set(value) {
        field = value
        notifyChange()
    }

    fun onCreate(chooseCurrency: String) {
        when (chooseCurrency) {
            ChooseCurrency.SOURCE.toString() -> this.chooseCurrency = stringHelper.getString(R.string.choose_the_currency_of_origin)
            ChooseCurrency.DESTINY.toString() -> this.chooseCurrency = stringHelper.getString(R.string.choose_the_target_currency)
        }
        searchCurrencies()
    }

    private fun searchCurrencies() {
        getCurrenciesLocal.execute()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                contract.initializeAdapter(it)
            }, {
            })
            .also { addDisposable(it) }
    }
}