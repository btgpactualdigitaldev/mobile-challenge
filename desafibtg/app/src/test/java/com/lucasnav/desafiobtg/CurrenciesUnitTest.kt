package com.lucasnav.desafiobtg

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import com.lucasnav.desafiobtg.core.livedata.SingleLiveEvent
import com.lucasnav.desafiobtg.modules.currencyConverter.interactor.CurrencyInteractor
import com.lucasnav.desafiobtg.modules.currencyConverter.model.Currency
import com.lucasnav.desafiobtg.modules.currencyConverter.model.RequestError
import com.lucasnav.desafiobtg.modules.currencyConverter.viewmodel.CurrencyViewmodel
import com.nhaarman.mockito_kotlin.any
import com.nhaarman.mockito_kotlin.times
import com.nhaarman.mockito_kotlin.verify
import org.junit.Assert
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations

class CurrenciesUnitTests {

    private lateinit var currencyViewmodel: CurrencyViewmodel

    @Mock
    lateinit var currencyInteractor: CurrencyInteractor

    @Mock
    lateinit var currenciesObserverMock: Observer<List<Currency>>

    @Mock
    lateinit var onErrorMock: SingleLiveEvent<RequestError>

    @Rule
    @JvmField
    var testSchedulerRule = RxImmediateSchedulerRule()

    @Rule
    @JvmField
    val ruleForLivaData = InstantTaskExecutorRule()

    @Before
    fun setUp() {
        MockitoAnnotations.initMocks(this)
        currencyViewmodel = CurrencyViewmodel(currencyInteractor)
    }

    @Test
    fun `it should assert that currencies livedata has updated its value`() {

        val currencies =
            listOf(
                Currency(0, "", "")
            )

        currencyViewmodel.currencies.observeForever(currenciesObserverMock)

        currencyViewmodel.currencies.value = currencies

        verify(currenciesObserverMock, times(1)).onChanged(any())
        Assert.assertEquals(currencies, currencyViewmodel.currencies.value)
    }

    @Test
    fun `it should verify if onError live event has been called after updated its value`() {
        currencyViewmodel.onError = onErrorMock

        currencyViewmodel.onError.call()

        verify(onErrorMock, times(1)).call()
    }
}