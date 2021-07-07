package br.com.leonamalmeida.mobilechallenge.ui.currency

import br.com.leonamalmeida.mobilechallenge.data.Rate
import com.google.common.truth.Truth.assertThat
import junit.framework.Assert.assertEquals
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

/**
 * Created by Leo Almeida on 30/06/20.
 */
@RunWith(JUnit4::class)
class ConversionTest {

    private val originRate = Rate("USD", 1f, 1430401802)
    private val destinyRate = Rate("BRL", 5.4f, 1430401802)
    private val amount = 1

    @Test
    fun conversionMethod_IsCorrect() {
        val result = (amount / originRate.value) * destinyRate.value
        assertEquals(result, 5.4f)
    }

    @Test
    fun conversionMethod_IsInvalid() {
        val result = (amount / originRate.value) * destinyRate.value
        assertThat(result).isNotEqualTo(1)
    }
}