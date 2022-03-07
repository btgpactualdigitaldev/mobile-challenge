package com.kaleniuk2.conversordemoedas.util

import junit.framework.Assert.assertEquals
import org.junit.Test
import java.math.BigDecimal

class NumberUtilTest {

    @Test
    fun `when call parseStringToBigDecimal with param value should return bigdecimal converted`() {
        //when
        val result = NumberUtil.parseStringToBigDecimal("R$ 1,00")

        //then
        assertEquals(
            BigDecimal(1.00).setScale(2),
            result
        )
    }

    @Test
    fun `when call parseStringToBigDecimal with incorrect value should return bigdecimal of zero`() {
        //when
        val result = NumberUtil.parseStringToBigDecimal("R$ test")

        //then
        assertEquals(
            BigDecimal(0),
            result
        )
    }
}