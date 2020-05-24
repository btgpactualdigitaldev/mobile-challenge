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
import java.math.BigDecimal

@RunWith(RobolectricTestRunner::class)
@Config(application = TestApp::class, sdk = [Build.VERSION_CODES.P])
class GetQuoteDollarTest {

    private lateinit var applicationContext: Context
    private lateinit var repository: Repository

    @Before
    fun before() {
        applicationContext = InstrumentationRegistry.getInstrumentation().targetContext.applicationContext
        repository = Repository(applicationContext)

    }

    @Test
    fun `should return list of quote dollar with USDBRL`() {
        val currencies = "ARS,BRL"
        val value = BigDecimal(1.0)
        var valueReturn = BigDecimal(0.0)

        val quoteDollarResponse = GetQuoteDollar(repository).execute(BuildConfig.ACCESS_KEY, currencies).blockingGet()
        if(quoteDollarResponse.quotes.USDBRL > BigDecimal.ZERO) valueReturn = BigDecimal(1.0)
        Assert.assertEquals(value, valueReturn)
    }
}