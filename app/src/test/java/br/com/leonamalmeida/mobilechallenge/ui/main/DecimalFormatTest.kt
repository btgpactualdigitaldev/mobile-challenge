package br.com.leonamalmeida.mobilechallenge.ui.main

import br.com.leonamalmeida.mobilechallenge.util.formatDecimal
import com.google.common.truth.Truth
import org.junit.Test

/**
 * Created by Leo Almeida on 30/06/20.
 */

class DecimalFormatTest {
    @Test
    fun `check decimal format to display comma instead point as decimal divisor`() {
        Truth.assertThat(1000.56f.formatDecimal()).isEqualTo("1000,56")
    }
}