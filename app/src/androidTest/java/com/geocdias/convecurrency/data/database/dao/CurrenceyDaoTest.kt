package com.geocdias.convecurrency.data.database.dao

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.filters.SmallTest
import com.geocdias.convecurrency.data.database.CurrencyDatabase
import com.geocdias.convecurrency.data.database.CurrencyFakeProvider
import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.google.common.truth.Truth.assertThat
import getOrAwaitValue
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@ExperimentalCoroutinesApi
@RunWith(AndroidJUnit4::class)
@SmallTest
class CurrenceyDaoTest {
    private lateinit var database: CurrencyDatabase
    private lateinit var dao: CurrencyDao

    @get:Rule
    var instantTaskExecutorRule = InstantTaskExecutorRule()

    @Before
    fun setup() {
        database = Room.inMemoryDatabaseBuilder(
            ApplicationProvider.getApplicationContext(),
            CurrencyDatabase::class.java
        ).allowMainThreadQueries().build()

        dao = database.currencyDao()
    }

    @After
    fun teardown() {
        database.close()
    }

    @Test
    fun insertCurrencyList() = runBlockingTest {
        val currencyList: List<CurrencyEntity> = CurrencyFakeProvider.currencyList()

        dao.insertCurrencyList(currencyList)

        val allCurrencies: List<CurrencyEntity> = dao.observeCurrencyList().getOrAwaitValue()
        assertThat(allCurrencies).isEqualTo(currencyList.toList())
    }

    @Test
    fun getCurrencyByCode() = runBlockingTest {
        val currencyList: List<CurrencyEntity> = CurrencyFakeProvider.currencyList()
        dao.insertCurrencyList(currencyList)
        val code = "BRL"

        val currency = dao.getCurrencyByCode(code).getOrAwaitValue()

        assertThat(currency.code).isEqualTo(code)
    }

    @Test
    fun getCurrencyByName() = runBlockingTest {
        val currencyList: List<CurrencyEntity> = CurrencyFakeProvider.currencyList()
        dao.insertCurrencyList(currencyList)
        val name = "Real"

        val currencies = dao.getCurrencyByName(name).getOrAwaitValue()

        assertThat(currencies).isNotEmpty()
        assertThat(currencies.size).isEqualTo(1)
    }

    @Test
    fun getAllCurrencyCodes() = runBlockingTest {
        val currencyList: List<CurrencyEntity> = CurrencyFakeProvider.currencyList()
        val currencyCodes = CurrencyFakeProvider.currencyCodes()
        dao.insertCurrencyList(currencyList)

        val codes = dao.getAllCurrencyCodes().getOrAwaitValue()

        assertThat(codes).isEqualTo(currencyCodes)
    }
}
