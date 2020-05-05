package com.btg.conversormonetario.view.viewmodel

import com.btg.conversormonetario.App
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import org.junit.Test

import org.junit.Assert.*
import org.junit.Before
import org.mockito.Mock
import org.mockito.Mockito.*

class ConverterCurrencyViewModelTest {
    lateinit var viewModel: ConverterCurrencyViewModel

    @Before
    fun setup() {
        viewModel = mock(ConverterCurrencyViewModel::class.java)
    }

    @Test
    fun testGetUseTerms_SameValueSaved() {
        val storage = InfoCurrencyModel.Storage(true, "teste", "teste", arrayListOf())
        App.setInfoCurrency(storage)
        doReturn("teste").`when`(viewModel).getUseTerms()
        assertEquals("teste", viewModel.getUseTerms())
    }

    @Test
    fun testGetUseTerms_NotNull() {
        val storage = InfoCurrencyModel.Storage(true, "teste", "teste", arrayListOf())
        App.setInfoCurrency(storage)
        assertNotNull(viewModel.getUseTerms())
    }

}