package com.accenture.santander

import android.app.Activity
import org.junit.Assert.*
import android.view.View
import com.btg.teste.moneyConvert.MoneyConvertContracts
import com.btg.teste.moneyConvert.MoneyConvertPresenter
import com.btg.teste.viewmodel.Conversion
import com.btg.teste.viewmodel.MoneyConvert
import org.junit.*
import org.mockito.*
import org.mockito.Mockito.*

class TestMoneyConvertPresenter {

    lateinit var moneyConvertPresenter: MoneyConvertPresenter

    @Mock
    lateinit var iMoneyConvertPresenterOutput: MoneyConvertContracts.MoneyConvertPresenterOutput

    @Mock
    lateinit var activity: Activity

    @Before
    fun setup() {
        MockitoAnnotations.initMocks(this)
        moneyConvertPresenter =
            MoneyConvertPresenter(activity, View(activity), iMoneyConvertPresenterOutput)
        assertNotNull(moneyConvertPresenter)
    }

    @Test
    fun startOrigin() {
        moneyConvertPresenter.startOrigin()
    }

    @Test
    fun startRecipient() {
        moneyConvertPresenter.startRecipient()
    }

    @Test
    fun startCalculate() {
        val moneyConvert = MoneyConvert()
        moneyConvert.value = "12"
        moneyConvert.origin = null
        moneyConvertPresenter.startCalculate(moneyConvert)
        moneyConvert.value = "12"
        moneyConvert.origin = Conversion()
        moneyConvert.destination = null
        moneyConvertPresenter.startCalculate(moneyConvert)
        moneyConvert.value = "12"
        moneyConvert.origin = Conversion().apply { value = 1.0 }
        moneyConvert.destination = Conversion().apply { value = 1.0 }
        moneyConvertPresenter.startCalculate(moneyConvert)
        verify(iMoneyConvertPresenterOutput, times(2)).returnErrorMessage(anyInt())
        verify(iMoneyConvertPresenterOutput, times(1)).returnValueFinal(Matchers.anyString())
    }
}
