package com.hotmail.fignunes.btg.presentation.quotedollar.actions

import android.content.Context
import android.os.Build
import androidx.test.platform.app.InstrumentationRegistry
import com.hotmail.fignunes.btg.BuildConfig
import com.hotmail.fignunes.btg.repository.Repository
import com.hotmail.fignunes.desafio_mobile.repository.remote.TestApp
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(application = TestApp::class, sdk = [Build.VERSION_CODES.P])
class GetCurrenciesTest {

    private lateinit var applicationContext: Context
    private lateinit var repository: Repository

    @Before
    fun before() {
        applicationContext = InstrumentationRegistry.getInstrumentation().targetContext.applicationContext
        repository = Repository(applicationContext)

    }

    @Test
    fun `should return list of currencies with brl`() {

        var brazil = "Brazilian Real"
        val currencies = GetCurrencies(repository).execute(BuildConfig.ACCESS_KEY).blockingGet()
        val result = currencies.currencies.BRL
        Assert.assertEquals(brazil, result)
    }
}