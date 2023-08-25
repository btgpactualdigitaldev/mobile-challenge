package br.com.btg.mobile.challenge.base

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import br.com.btg.mobile.challenge.di.appModule
import br.com.btg.mobile.challenge.helper.CoroutinesTestRule
import br.com.btg.mobile.challenge.helper.MockWebServerRule
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.ExperimentalCoroutinesApi
import org.junit.Rule
import org.koin.core.logger.Level
import org.koin.core.qualifier.named
import org.koin.dsl.module
import org.koin.test.KoinTest
import org.koin.test.KoinTestRule

private const val IO_DISPATCHER = "IO"

@ExperimentalCoroutinesApi
abstract class BaseViewModelTest : KoinTest {

    @get:Rule
    var rule = InstantTaskExecutorRule()

    @get:Rule
    var coroutinesTestRule = CoroutinesTestRule()

    @get:Rule
    var mockWebServerRule = MockWebServerRule()

    @get:Rule
    val koinRoleTest = KoinTestRule.create {
        printLogger(Level.ERROR)
        modules(appModule)
        module(override = true) {
            single<CoroutineDispatcher>(named(IO_DISPATCHER)) {
                coroutinesTestRule.testDispatcher
            }
        }
    }
}
