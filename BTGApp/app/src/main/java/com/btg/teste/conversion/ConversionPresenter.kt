package com.btg.teste.conversion

import android.app.Activity
import android.view.View
import com.btg.teste.entity.Currencies
import com.btg.teste.entity.CurrencyLayer
import com.btg.teste.viewmodel.Conversion
import com.btg.teste.viewmodel.ConversionViewModel
import java.util.*
import javax.inject.Inject
import kotlin.collections.ArrayList

class ConversionPresenter(
    activity: Activity,
    view: View,
    var origin: Boolean,
    private val iConversionPresenterOutput: ConversionContracts.ConversionPresenterOutput
) : ConversionContracts.ConversionPresenterInput, ConversionContracts.ConversionInteractorOutput {

    @Inject
    lateinit var iConversionInteractorInput: ConversionContracts.ConversionInteractorInput

    @Inject
    lateinit var conversionRouter: ConversionRouter

    init {
        DaggerConversionComponents
            .builder()
            .conversionModule(
                ConversionModule(
                    context = activity,
                    view = view,
                    origin = origin,
                    conversionPresenter = this
                )
            )
            .build()
            .inject(this)
    }

    override fun popConversions(conversion: Conversion?) {
        if (origin) {
            iConversionPresenterOutput.upOrigin(conversion)
        } else {
            iConversionPresenterOutput.upRecipient(conversion)
        }
        conversionRouter.popBackStack()
    }

    override fun loadConversions(conversion: ConversionViewModel, reload: Boolean) {
        if (conversion.listfilter.isNullOrEmpty() || reload) {
            iConversionPresenterOutput.visibleRefrash()
            iConversionInteractorInput.searchCurrencies()
        } else {
            iConversionPresenterOutput.goneRefrash()
            iConversionPresenterOutput.visibleFilter()
        }
    }

    override fun resultCurrencyLayer(conversion: CurrencyLayer, currencies: Currencies?) {
        val currencyLayerMap = currencies?.currencies?.map {
            Conversion().mapper(it.key, it.value)
        }?.toMutableList() ?: ArrayList()

        currencyLayerMap.sortedBy {
            it.name
            it.currency
        }.forEach { convert ->
            conversion.quotes.forEach {
                if (it.key.contains(convert.currency)) {
                    convert.value = it.value
                    return@forEach
                }
            }
        }

        iConversionPresenterOutput.apresentationConversions(currencyLayerMap)
        iConversionPresenterOutput.goneRefrash()
        iConversionPresenterOutput.visibleFilter()
    }

    override fun filter(filter: String, conversions: MutableList<Conversion>) {

        var filterCollection = conversions
        if(filter.isNotEmpty()) {
            filterCollection = conversions.filter {
                it.currency.toLowerCase(Locale.getDefault()).contains(filter.toLowerCase(Locale.getDefault())) ||
                        it.name.toLowerCase(Locale.getDefault()).contains(filter.toLowerCase(Locale.getDefault()))
            }.sortedBy {
                it.name
                it.currency
            }.toMutableList()
        }

        iConversionPresenterOutput.apresentationConversionsFilter(filterCollection)
    }

    override fun failResquest(code: Int) {
        iConversionPresenterOutput.goneRefrash()
        iConversionPresenterOutput.failRequest()
    }

    override fun errorCurrencyLayer(throwable: Throwable) {
        iConversionPresenterOutput.goneRefrash()
        iConversionPresenterOutput.errorConversions()
    }

    override fun failNetWork() {
        iConversionPresenterOutput.goneRefrash()
        iConversionPresenterOutput.failNetWork()
    }

    override fun cleanConversions() {
        iConversionPresenterOutput.getConversions().clear()
    }

    override fun cleanAndAddConversions(conversions: MutableList<Conversion>) {
        iConversionPresenterOutput.getConversions().clear()
        iConversionPresenterOutput.getConversions().addAll(conversions)
    }

    override fun errorMensage(mensage: String?) {
        iConversionPresenterOutput.errorService(mensage)
    }
}