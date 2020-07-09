package com.carlos.silva.desafiobtg

import com.google.gson.internal.LinkedTreeMap

fun <T, E> Any.toArrayPair(): MutableList<Pair<T, E>> {
    val map = this as LinkedTreeMap<T, E>
    return mutableListOf<Pair<T, E>>().apply {
        map.keys.forEach { k ->
            map[k]?.let { r ->
                add(
                    Pair<T, E>(k, r)
                )
            }
        }
    }
}