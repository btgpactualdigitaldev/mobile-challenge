package br.net.easify.currencydroid.database

import android.content.Context
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import br.net.easify.currencydroid.database.dao.CurrencyDao
import br.net.easify.currencydroid.database.dao.QuoteDao
import br.net.easify.currencydroid.database.model.Currency
import br.net.easify.currencydroid.database.model.Quote
import org.junit.*
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
class ReadWriteTests {

    @get:Rule
    var instantTask = InstantTaskExecutorRule()

    private lateinit var database: AppDatabase
    private lateinit var currencyDao: CurrencyDao
    private lateinit var quoteDao: QuoteDao

    @Before
    fun createDb() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        database = Room
            .inMemoryDatabaseBuilder(context, AppDatabase::class.java)
            .allowMainThreadQueries()
            .build()

        currencyDao = database.currencyDao()
        quoteDao = database.quoteDao()
    }

    @After
    fun closeDb() {
        database.close()
    }

    private fun insertCurrency() {
        val currencyList: ArrayList<Currency> = arrayListOf()
        currencyList.add(Currency(0, "BRL", "Brazilian Real"))
        currencyDao.insert(currencyList)
    }

    private fun insertQuote() {
        val quoteList: ArrayList<Quote> = arrayListOf()
        quoteList.add(Quote(0, "USDBRL", 5.6F))
        quoteDao.insert(quoteList)
    }

    @Test
    fun `CURRENCY - testando inserção de currency`() {
        currencyDao.deleteAll()
        var currencyList = currencyDao.getAll()
        var size = currencyList.size
        Assert.assertTrue(size == 0)
        insertCurrency()
        currencyList = currencyDao.getAll()
        size = currencyList.size
        Assert.assertTrue(size == 1)
    }

    @Test
    fun `CURRENCY - testando getCurrency por currencyId`() {
        currencyDao.deleteAll()
        var currencyList = currencyDao.getAll()
        var size = currencyList.size
        Assert.assertTrue(size == 0)
        insertCurrency()
        val currency = currencyDao.getCurrency("BRL")
        Assert.assertNotNull(currency)
    }

    @Test
    fun `CURRENCY - testando getCurrency por id`() {
        currencyDao.deleteAll()
        var currencyList = currencyDao.getAll()
        var size = currencyList.size
        Assert.assertTrue(size == 0)
        insertCurrency()
        val currency = currencyDao.getCurrency(1)
        Assert.assertNotNull(currency)
    }

    @Test
    fun `QUOTE - testando inserção de quote`() {
        quoteDao.deleteAll()
        var quoteList = quoteDao.getAll()
        var size = quoteList.size
        Assert.assertTrue(size == 0)
        insertQuote()
        quoteList = quoteDao.getAll()
        size = quoteList.size
        Assert.assertTrue(size == 1)
    }

    @Test
    fun `QUOTE - testando getQuote`() {
        quoteDao.deleteAll()
        var quoteList = quoteDao.getAll()
        var size = quoteList.size
        Assert.assertTrue(size == 0)
        insertQuote()
        val quote = quoteDao.getQuote("___BRL")
        Assert.assertNotNull(quote)
    }
}