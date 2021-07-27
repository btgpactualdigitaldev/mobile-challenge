package com.hotmail.fignunes.btg.presentation.common

import android.content.Context
import androidx.test.platform.app.InstrumentationRegistry
import com.hotmail.fignunes.btg.model.Currency
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner

@RunWith(RobolectricTestRunner::class)
class ReadInstancePropertyTest {

    private lateinit var applicationContext: Context

    @Before
    fun before() {
        applicationContext = InstrumentationRegistry.getInstrumentation().targetContext.applicationContext
    }

    @Test
    fun `should return property value`() {

        val currency = Currency("BRL", "Brazil")

        val result = ReadInstanceProperty().execute<String>(currency, "description")
        Assert.assertEquals("Brazil", result)
    }
}

