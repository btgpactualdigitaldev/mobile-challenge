package com.a.coinmaster.usecase

interface UseCase<T, U> {
    fun execute(param: T): U
}
