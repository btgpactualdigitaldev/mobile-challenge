package com.btg.teste.components

import org.junit.Test
import org.junit.Assert

class TestAny {

    @Test
    fun notNull() {
        val item = "";
        Assert.assertNotNull(item.notNull())
    }

}