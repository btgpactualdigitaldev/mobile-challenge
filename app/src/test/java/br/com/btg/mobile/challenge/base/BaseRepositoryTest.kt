package br.com.btg.mobile.challenge.base

import br.com.btg.mobile.challenge.di.appModule
import br.com.btg.mobile.challenge.helper.MockWebServerRule
import org.junit.Rule
import org.koin.core.logger.Level
import org.koin.test.KoinTest
import org.koin.test.KoinTestRule

abstract class BaseRepositoryTest : KoinTest {

    @get:Rule
    var mockWebServerRule = MockWebServerRule()

    @get:Rule
    val koinRoleTest = KoinTestRule.create {
        printLogger(Level.ERROR)
        modules(appModule)
    }
}
