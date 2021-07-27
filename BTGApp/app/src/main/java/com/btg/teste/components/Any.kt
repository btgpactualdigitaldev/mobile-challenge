package com.btg.teste.components

import kotlin.contracts.ExperimentalContracts
import kotlin.contracts.contract

@UseExperimental(ExperimentalContracts::class)
fun Any?.notNull(): Boolean {
    contract {
        returns(true) implies (this@notNull != null)
    }
    return this != null
}