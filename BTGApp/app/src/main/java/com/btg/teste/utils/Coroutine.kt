package com.btg.teste.utils

object Coroutine {
    fun start(r: () -> Unit) {
        val t = Thread(r);
        t.start()
        t.join()
    }
}