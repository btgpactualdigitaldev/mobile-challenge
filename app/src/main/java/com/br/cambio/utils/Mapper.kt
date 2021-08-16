package com.br.cambio.utils

interface Mapper<S, T> {
    fun map(source: S): T
}