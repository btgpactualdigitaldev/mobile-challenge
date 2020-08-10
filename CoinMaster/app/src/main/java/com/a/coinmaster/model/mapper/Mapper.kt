package com.a.coinmaster.model.mapper

interface Mapper<S,T> {
    fun map(from: S): T
}