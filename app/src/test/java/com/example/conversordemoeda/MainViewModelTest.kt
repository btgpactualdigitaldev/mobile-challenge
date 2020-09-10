package com.example.conversordemoeda

import com.example.conversordemoeda.model.repositorio.MoedaRepository
import com.example.conversordemoeda.viewmodel.MainViewModel
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test
import org.mockito.Mockito
import org.mockito.MockitoAnnotations

class MainViewModelTest {

    @Before
    fun setUp() {
        MockitoAnnotations.initMocks(this)
    }

    @Test
    fun setDefinirCambioDeOrigemTest() {
        val viewModel = MainViewModel(Mockito.mock(MoedaRepository::class.java))
        viewModel.definirCambioDeOrigem("USD")
        assertEquals("USD", viewModel.cambioDeOrigem)
    }

    @Test
    fun setDefinirCambioDeDestinoTest() {
        val viewModel = MainViewModel(Mockito.mock(MoedaRepository::class.java))
        viewModel.definirCambioDeDestino("BRL")
        assertEquals("BRL", viewModel.cambioDeDestino)
    }

    @Test
    fun setValorTest() {
        val viewModel = MainViewModel(Mockito.mock(MoedaRepository::class.java))
        viewModel.setValor(5F)
        assertEquals(5F, viewModel.valorInformado)
    }

    @Test
    fun dividirValorTest() {
        val viewModel = MainViewModel(Mockito.mock(MoedaRepository::class.java))
        val cotacao = 1.6F
        val valor = 5.94F

        assertEquals(3.7125F, viewModel.dividirValor(cotacao, valor))
    }

    @Test
    fun multiplicarValorTest() {
        val viewModel = MainViewModel(Mockito.mock(MoedaRepository::class.java))
        val cotacao = 1.6F
        val valor = 5.94F

        assertEquals(9.504001F, viewModel.multiplicarValor(cotacao, valor))
    }

}