package com.example.currencyconverter

import com.example.currencyconverter.logic.CurrenciesInteractor
import com.example.currencyconverter.mocks.CurrencyListViewMock
import com.example.currencyconverter.mocks.DatabaseMock
import org.junit.After
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test

class CurrenciesUnitTest {

    private val mockView =
        CurrencyListViewMock()
    private val mockDatabase = DatabaseMock()
    private val interactor = CurrenciesInteractor(mockView, mockDatabase)

    @Before
    fun setupMock() {
        mockDatabase.onCreateCalled = false
        mockDatabase.onDestroyCalled = false
        mockDatabase.postCurrenciesCalled = false
        mockView.calledFinishWithResultingCurrency = false
        mockView.calledSetOrderButtonText = false
        mockView.calledSetRecyclerViewArray = false
        mockView.currencyList = arrayListOf()
    }

    @Test
    fun databaseCreationTest() {
        assertFalse(mockDatabase.onCreateCalled)
        interactor.onCreate()
        assertTrue(mockDatabase.onCreateCalled)
    }

    @Test
    fun searchReflectTest() {
        assertFalse(mockView.calledSetRecyclerViewArray)
        interactor.search("USD")
        assertEquals("USD", mockView.currencyList[0].symbol)
        assertEquals(1, mockView.currencyList.size)
        assertTrue(mockView.calledSetRecyclerViewArray)
    }

    @Test
    fun emptySearchReflectTest() {
        assertFalse(mockView.calledSetRecyclerViewArray)
        interactor.search("")
        assertEquals("USD", mockView.currencyList[1].symbol)
        assertEquals(2, mockView.currencyList.size)
        assertTrue(mockView.calledSetRecyclerViewArray)
    }

    @Test
    fun clearSearchReflectTest() {
        assertFalse(mockView.calledSetRecyclerViewArray)
        interactor.clearSearch()
        assertTrue(mockView.calledSetRecyclerViewArray)
    }

    @Test
    fun orderByTickerReflectTest() {
        assertFalse(mockView.calledSetRecyclerViewArray)
        interactor.orderByTicker()
        assertTrue(mockView.calledSetRecyclerViewArray)
    }

    @Test
    fun orderByNameReflectTest() {
        assertFalse(mockView.calledSetRecyclerViewArray)
        interactor.orderByName()
        assertTrue(mockView.calledSetRecyclerViewArray)
    }

    @Test
    fun reorderListReflectTest() {
        assertFalse(mockView.calledSetRecyclerViewArray)
        interactor.reorderList()
        assertTrue(mockView.calledSetRecyclerViewArray)
    }

    @After
    fun destroyDatabase() {
        interactor.onDestroy()
    }
}