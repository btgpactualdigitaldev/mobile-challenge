package com.hotmail.fignunes.btg.presentation.common

import kotlin.reflect.KProperty1
import kotlin.reflect.full.memberProperties

class ReadInstanceProperty {

    @Suppress("UNCHECKED_CAST")
    fun <R> execute(instance: Any, propertyName: String): R {
        val property = instance::class.memberProperties
            .first { it.name == propertyName } as KProperty1<Any, *>
        return property.get(instance) as R
    }
}