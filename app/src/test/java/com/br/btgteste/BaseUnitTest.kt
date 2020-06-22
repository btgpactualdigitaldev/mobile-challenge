package com.br.btgteste

import com.br.btgteste.domain.usecase.BaseUseCase
import com.br.btgteste.domain.usecase.ResponseBlock
import com.nhaarman.mockitokotlin2.any
import com.nhaarman.mockitokotlin2.argumentCaptor
import kotlinx.coroutines.runBlocking
import org.mockito.Mockito

inline fun test(block: Test.() -> Unit) {
    Test().apply(block)
}

class Test {
    fun act(block: suspend () -> Unit) {
        apply {
            runBlocking {
                block.invoke()
            }
        }
    }

    fun arrange(block: suspend () -> Unit) {
        apply {
            runBlocking {
                block.invoke()
            }
        }
    }

    fun assert(block: suspend () -> Unit) {
        apply {
            runBlocking {
                block.invoke()
            }
        }
    }
}

internal inline fun <reified PARAM: Any, reified RESPONSE: Any> getCompletionBlockFromUseCase(
    baseUseCaseMock: BaseUseCase<PARAM, RESPONSE>
): ResponseBlock<RESPONSE> {
    val captor = argumentCaptor<ResponseBlock<RESPONSE>>()
    Mockito.verify(baseUseCaseMock).invoke(any(), captor.capture())
    return captor.firstValue
}
