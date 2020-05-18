package com.btg.teste.Utils

import com.btg.teste.utils.Coroutine
import com.btg.teste.utils.MoneyFormact
import org.junit.Test
import org.junit.Assert

class TestMoneyFormact {

    @Test
    fun start() {
        Assert.assertEquals(MoneyFormact.mask(123.0), "R$ 123,00")
    }

}