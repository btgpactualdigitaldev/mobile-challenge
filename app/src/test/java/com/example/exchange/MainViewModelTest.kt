package com.example.exchange

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import com.example.exchange.fragment.CoinFragment
import com.example.exchange.fragment.ConverterFragment
import com.example.exchange.fragment.StartFragment
import com.example.exchange.viewmodel.MainViewModel
import junit.framework.TestCase.assertNotNull
import junit.framework.TestCase.assertNull
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TestRule
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.*
import org.mockito.Mockito.verify

@RunWith(JUnit4::class)
class MainViewModelTest {

    @get:Rule
    var instantTaskExecutorRule: TestRule = InstantTaskExecutorRule()

    @Mock
    lateinit var observerFragment: Observer<Fragment>

    @Mock
    lateinit var startFragment: StartFragment

    @Mock
    lateinit var coinFragment: CoinFragment

    @Mock
    lateinit var converterFragment: ConverterFragment

    lateinit var viewmodel: MainViewModel

    @Before
    fun setUp() {
        MockitoAnnotations.initMocks(this)

        viewmodel = MainViewModel()
        viewmodel.getScreenSelected().observeForever(observerFragment)
    }

    @Test
    fun changeFragmentIsNull() {
        viewmodel.defineScreen(null)
        assertNull(viewmodel.getScreenSelected().value)
    }

    @Test
    fun changeFragmentIsNotNull() {
        viewmodel.defineScreen(Fragment())
        assertNotNull(viewmodel.getScreenSelected())
    }

    @Test
    fun changeAmongFragments() {
        viewmodel.defineScreen(startFragment)
        verify(observerFragment).onChanged(startFragment)

        viewmodel.defineScreen(coinFragment)
        verify(observerFragment).onChanged(coinFragment)

        viewmodel.defineScreen(converterFragment)
        verify(observerFragment).onChanged(converterFragment)
    }
}