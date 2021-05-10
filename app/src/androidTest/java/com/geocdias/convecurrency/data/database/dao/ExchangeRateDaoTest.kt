package com.geocdias.convecurrency.data.database.dao

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.filters.SmallTest
import com.geocdias.convecurrency.ExchangeRateFakeProvider
import com.geocdias.convecurrency.data.database.CurrencyDatabase
import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity
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
class ExchangeRateDaoTest {
    private lateinit var database: CurrencyDatabase
    private lateinit var dao: ExchangeRateDao

    @get:Rule
    var instantTaskExecutorRule = InstantTaskExecutorRule()

    @Before
    fun setup() {
        database = Room.inMemoryDatabaseBuilder(
            ApplicationProvider.getApplicationContext(),
            CurrencyDatabase::class.java
        ).allowMainThreadQueries().build()

        dao = database.exchangeRateDao()
    }

    @After
    fun teardown() {
        database.close()
    }

    @Test
    fun insertExchangeRateList() = runBlockingTest {
        val rateList: List<ExchangeRateEntity> = ExchangeRateFakeProvider.rateList()

        dao.insertExchangeRate(rateList)

        val allCurrencies: List<ExchangeRateEntity> = dao.observeExchangeRateList().getOrAwaitValue()
        assertThat(allCurrencies).isEqualTo(rateList)
    }

    @Test
    fun getRate() = runBlockingTest {
        val rateList: List<ExchangeRateEntity> = ExchangeRateFakeProvider.rateList()
        dao.insertExchangeRate(rateList)
        val quote = "USDAED"

        val currencyEntity = dao.getRate(quote).getOrAwaitValue()

        assertThat(currencyEntity).isNotNull()
        assertThat(currencyEntity?.rate).isEqualTo(3.672982)
    }
}
