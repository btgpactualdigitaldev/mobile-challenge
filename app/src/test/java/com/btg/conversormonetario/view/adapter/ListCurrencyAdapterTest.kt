package com.btg.conversormonetario.view.adapter

import android.content.Context
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import com.btg.conversormonetario.view.viewmodel.ChooseCurrencyViewModel
import com.btg.conversormonetario.view.viewmodel.ConverterCurrencyViewModel
import org.junit.Before
import org.junit.Test

import org.junit.Assert.*
import org.mockito.Mock
import org.mockito.Mockito.mock
import org.mockito.Mockito.spy

class ListCurrencyAdapterTest {

    lateinit var adapter: ListCurrencyAdapter

    @Test
    fun testGetItemCount_NotNull() {
        adapter = spy(
            ListCurrencyAdapter(
                mock(Context::class.java),
                mock(ChooseCurrencyViewModel::class.java),
                arrayListOf(InfoCurrencyModel.DTO("1", "1"))
            )
        )

        assertNotNull(adapter.itemCount)
    }

    @Test
    fun testGetItemCount_Null() {
        adapter = spy(
            ListCurrencyAdapter(
                mock(Context::class.java),
                mock(ChooseCurrencyViewModel::class.java),
                arrayListOf()
            )
        )

        assertEquals(0, adapter.itemCount)
    }
}