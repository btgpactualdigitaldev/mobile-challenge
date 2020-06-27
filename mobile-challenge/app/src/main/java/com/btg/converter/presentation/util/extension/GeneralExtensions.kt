package com.btg.converter.presentation.util.extension

fun consume(f: () -> Unit): Boolean {
    f()
    return true
}