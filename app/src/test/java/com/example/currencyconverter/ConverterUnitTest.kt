package com.example.currencyconverter

import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.infrastructure.database.DatabaseInstance
import com.example.currencyconverter.infrastructure.network.ListAPIResponseModel
import com.example.currencyconverter.infrastructure.network.LiveAPIResponseModel
import com.example.currencyconverter.logic.ConverterInteractor
import com.example.currencyconverter.mocks.DatabaseMock
import com.example.currencyconverter.mocks.MessageViewMock
import com.example.currencyconverter.presentation.converter.ConverterActivity
import io.reactivex.disposables.CompositeDisposable
import org.junit.Test
import org.junit.Assert.*

class ConverterUnitTest {
    private val mockMessageView = MessageViewMock()
    private val mockDatabase = DatabaseMock()
    val interactor = ConverterInteractor(ConverterActivity(), mockMessageView, mockDatabase, CompositeDisposable())

    @Test
    fun currencyConversionHappyTest1() {
        interactor.originalValue = 1.00
        interactor.originalCurrency = Currency("USD", "Dollar", 1.00)
        interactor.convertedCurrency = Currency("BRL", "Reais", 5.3265)

        assertEquals(5.3265, interactor.calculateConvertedValue(), 0.0)
    }

    @Test
    fun currencyConversionHappyTest2() {
        interactor.originalValue = 10.00
        interactor.originalCurrency = Currency("USD", "Dollar", 1.00)
        interactor.convertedCurrency = Currency("BRL", "Reais", 5.3277)

        assertEquals(53.277, interactor.calculateConvertedValue(),0.0)
    }

    @Test
    fun currencyConversionHappyTest3() {
        interactor.originalValue = 1000.00000
        interactor.originalCurrency = Currency("BRA", "Brazil", 2.00)
        interactor.convertedCurrency = Currency("BRL", "Reais", 4.2266)

        assertEquals(2113.3, interactor.calculateConvertedValue(), 0.0)
    }

    @Test
    fun compileResponsesTest() {
        val currencies = mapOf(
            "AED" to "United Arab Emirates Dirham",
            "AFN" to "Afghan Afghani",
            "ALL" to "Albanian Lek",
            "AMD" to "Armenian Dram",
            "ANG" to "Netherlands Antillean Guilder")

        val quotes = mapOf(
            "USDAED" to 3.672998,
            "USDAFN" to 77.298682,
            "USDALL" to 110.249843,
            "USDAMD" to 481.409725,
            "USDANG" to 1.795645)

        val expectedCompilatedList = listOf(
            Currency("AED", "United Arab Emirates Dirham", 3.672998),
            Currency("AFN", "Afghan Afghani", 77.298682),
            Currency("ALL", "Albanian Lek", 110.249843),
            Currency("AMD", "Armenian Dram", 481.409725),
            Currency("ANG", "Netherlands Antillean Guilder", 1.795645))

        interactor.listResponse = ListAPIResponseModel(true, "www.terms", "www.privacy", currencies)
        interactor.liveResponse = LiveAPIResponseModel(true, "www.terms", "www.privacy", quotes)
        interactor.compileResponsesIntoCurrencyList()
        assertEquals(expectedCompilatedList, interactor.currencyList)
    }
}
