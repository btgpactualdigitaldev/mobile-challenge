package com.btg.teste.conversion

import com.btg.teste.entity.Currencies
import com.btg.teste.entity.CurrencyLayer
import com.btg.teste.viewmodel.Conversion
import com.btg.teste.viewmodel.ConversionViewModel

interface ConversionContracts {

    interface ConversionPresenterInput {
        fun loadConversions(conversion: ConversionViewModel, reload: Boolean)
        fun popConversions(conversion: Conversion?)
        fun cleanConversions()
        fun cleanAndAddConversions(conversions: MutableList<Conversion>)
        fun filter(filter: String, conversions: MutableList<Conversion>)
    }

    interface ConversionInteractorInput {
        fun searchConversions(currencies: Currencies?)
        fun searchCurrencies()
    }

    interface ConversionInteractorOutput {
        fun resultCurrencyLayer(conversion: CurrencyLayer, currencies: Currencies?)
        fun errorCurrencyLayer(throwable: Throwable)
        fun failNetWork()
        fun failResquest(code: Int)
        fun errorMensage(mensage: String?)
    }

    interface ConversionPresenterOutput {
        fun upOrigin(conversion: Conversion?)
        fun upRecipient(conversion: Conversion?)
        fun apresentationConversions(conversions: MutableList<Conversion>)
        fun goneRefrash()
        fun visibleRefrash()
        fun getConversions(): MutableList<Conversion>
        fun errorConversions()
        fun failNetWork()
        fun failRequest()
        fun errorService(mensage: String?)
        fun visibleFilter()
        fun apresentationConversionsFilter(conversions: MutableList<Conversion>)
    }

    interface ConversionFilter {
        fun filter(editable: android.text.Editable)
    }
}