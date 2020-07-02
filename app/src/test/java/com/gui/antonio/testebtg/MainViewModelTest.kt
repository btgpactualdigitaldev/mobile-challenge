package com.gui.antonio.testebtg

import com.gui.antonio.testebtg.repository.IAppRepository
import com.gui.antonio.testebtg.viewmodel.MainViewModel
import junit.framework.Assert.assertEquals
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.Mock
import org.mockito.MockitoAnnotations

@RunWith(JUnit4::class)
class MainViewModelTest {

    @Mock
    var mainViewModel: MainViewModel? = null
    @Mock
    lateinit var repository: IAppRepository

    @Before
    fun init(){
        MockitoAnnotations.initMocks(this)
        mainViewModel = MainViewModel(repository)
    }

    @Test
    fun verifyMethodConvert() {
        assertEquals(5.32, mainViewModel?.convert(1.0, 5.32))
    }

}