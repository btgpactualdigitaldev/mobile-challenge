package com.hotmail.fignunes.btg.presentation.currencies.actions

import android.content.Context
import android.os.Build
import androidx.room.Room
import androidx.test.platform.app.InstrumentationRegistry
import com.hotmail.fignunes.btg.model.Currency
import com.hotmail.fignunes.btg.repository.local.LocalCurrencyRepository
import com.hotmail.fignunes.btg.repository.local.currency.entity.CurrencyDatabase
import com.hotmail.fignunes.desafio_mobile.repository.remote.TestApp
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.core.context.stopKoin
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(application = TestApp::class, sdk = [Build.VERSION_CODES.P])
class GetCurrenciesLocalTest {

    private lateinit var currencyDatabase: CurrencyDatabase
    private lateinit var applicationContext: Context
    private lateinit var currencyRepository: LocalCurrencyRepository

    private val currencies = listOf(
        Currency("BRL","Brazilian Real"),
        Currency("ARS","Argentine Peso")
    )

    @Before
    fun before() {
        stopKoin()
        applicationContext = InstrumentationRegistry.getInstrumentation().targetContext.applicationContext
        currencyDatabase = Room.inMemoryDatabaseBuilder(applicationContext, CurrencyDatabase::class.java)
            .allowMainThreadQueries()
            .build()
        currencyRepository = LocalCurrencyRepository(currencyDatabase)
    }

    @After
    fun `close database`() {
        currencyDatabase.close()
    }


    @Test
    fun `get Currency when no Currency inserted`() {
        currencyRepository.getCurrencyAll()
            .test()
            .assertValue(listOf())
    }

    @Test
    fun `save Currency and get him`() {
        currencyRepository.apply {
            saveCurrency(currencies)
                .andThen(getCurrencyAll())
                .test()
                .assertValue(currencies)
        }
    }

    @Test
    fun `save Currency and delete all`() {
        currencyRepository.apply {
            saveCurrency(currencies)
                .andThen(deleteAll())
                .andThen(getCurrencyAll())
                .test()
                .assertValue(listOf())
        }
    }

    @Test
    fun `save Currencies and newCurrencies and get the last inserted`() {
        val newCurrencies = currencies + listOf(Currency("BTC","Bitcoin"))

        currencyRepository.apply {
            saveCurrency(currencies)
                .andThen(saveCurrency(newCurrencies))
                .andThen(getCurrencyAll())
                .test()
                .assertValue(newCurrencies)
        }
    }
}