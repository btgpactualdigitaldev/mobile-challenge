package com.btg.teste.conversion

import android.app.Activity
import org.junit.Test
import android.view.View
import com.btg.teste.entity.Currencies
import com.btg.teste.entity.CurrencyLayer
import com.btg.teste.viewmodel.Conversion
import com.btg.teste.viewmodel.ConversionViewModel
import org.junit.Assert
import org.junit.Before
import org.mockito.*
import kotlin.collections.ArrayList

class TestConversionPresenter {

    lateinit var conversionPresenter: ConversionPresenter

    @Mock
    lateinit var iConversionInteractorInput: ConversionContracts.ConversionInteractorInput

    @Mock
    lateinit var iConversionPresenterOutput: ConversionContracts.ConversionPresenterOutput

    @Mock
    lateinit var activity: Activity

    @Before
    fun setup() {
        MockitoAnnotations.initMocks(this)
        conversionPresenter =
            ConversionPresenter(activity, View(activity), true, iConversionPresenterOutput)
        conversionPresenter.iConversionInteractorInput = iConversionInteractorInput
        conversionPresenter.conversionRouter = ConversionRouter(View(activity))
        Assert.assertNotNull(conversionPresenter)
    }

    @Test
    fun popConversions() {
        try {
            conversionPresenter.popConversions(Conversion())
            Mockito.verify(iConversionPresenterOutput, Mockito.times(1))
                .upOrigin(Mockito.any(Conversion::class.java))
        } catch (ex: Exception) {
        }
        conversionPresenter.origin = false

        try {
            conversionPresenter.popConversions(Conversion())
            Mockito.verify(iConversionPresenterOutput, Mockito.times(1))
                .upRecipient(Mockito.any(Conversion::class.java))
        } catch (ex: Exception) {
        }
    }

    @Test
    fun loadConversions() {
        val viewmodel = ConversionViewModel()
        viewmodel.listfilter.add(Conversion())
        conversionPresenter.loadConversions(viewmodel, true)
        Mockito.verify(iConversionInteractorInput, Mockito.times(1))
            .searchCurrencies()
        conversionPresenter.loadConversions(viewmodel, false)
        Mockito.verify(iConversionPresenterOutput, Mockito.times(1))
            .goneRefrash()
    }

    @Test
    fun resultCurrencyLayer() {
        conversionPresenter.resultCurrencyLayer(CurrencyLayer(), Currencies())
        Mockito.verify(iConversionPresenterOutput, Mockito.times(1))
            .visibleFilter()
    }

    @Test
    fun filter() {
        conversionPresenter.filter("", ArrayList())
        Mockito.verify(iConversionPresenterOutput, Mockito.times(1))
            .apresentationConversionsFilter(Mockito.anyListOf(Conversion::class.java))
    }

    @Test
    fun failResquest() {
        conversionPresenter.failResquest(404)
        Mockito.verify(iConversionPresenterOutput, Mockito.times(1)).failRequest()
    }

    @Test
    fun errorCurrencyLayer() {
        conversionPresenter.errorCurrencyLayer(Throwable())
        Mockito.verify(iConversionPresenterOutput, Mockito.times(1)).errorConversions()
    }

    @Test
    fun failNetWork() {
        conversionPresenter.failNetWork()
        Mockito.verify(iConversionPresenterOutput, Mockito.times(1)).failNetWork()
    }

    @Test
    fun cleanConversions() {
        conversionPresenter.cleanConversions()
        Mockito.verify(iConversionPresenterOutput, Mockito.times(1)).getConversions()
    }

    @Test
    fun cleanAndAddConversions() {
        conversionPresenter.cleanAndAddConversions(ArrayList())
        Mockito.verify(iConversionPresenterOutput, Mockito.times(2)).getConversions()
    }

    @Test
    fun errorMensage() {
        conversionPresenter.errorMensage("")
        Mockito.verify(iConversionPresenterOutput, Mockito.times(1))
            .errorService(Mockito.anyString())
    }

}