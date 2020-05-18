package com.btg.teste.conversion

import android.app.Activity
import org.junit.Test
import com.btg.teste.ServiceTest.TestConversionApi
import com.btg.teste.ServiceTest.TestServiceConversion
import com.btg.teste.entity.Currencies
import org.junit.Assert
import org.junit.Before
import org.mockito.*

class TestConversionInteractor {

    lateinit var conversionInteractor: ConversionInteractor

    @Mock
    lateinit var iConversionInteractorOutput: ConversionContracts.ConversionInteractorOutput

    @Mock
    lateinit var activity: Activity

    @Before
    @TestConversionApi
    fun setup() {
        MockitoAnnotations.initMocks(this)
        conversionInteractor =
            ConversionInteractor(activity, iConversionInteractorOutput, TestServiceConversion())
        Assert.assertNotNull(conversionInteractor)
    }

    @Test
    fun searchCurrencies() {
        conversionInteractor.searchCurrencies()
        Mockito.verify(
            iConversionInteractorOutput,
            Mockito.times(1)
        ).failNetWork()
    }

    @Test
    fun searchConversions() {
        conversionInteractor.searchConversions(Currencies())
        Mockito.verify(
            iConversionInteractorOutput,
            Mockito.times(1)
        ).failNetWork()
    }
}