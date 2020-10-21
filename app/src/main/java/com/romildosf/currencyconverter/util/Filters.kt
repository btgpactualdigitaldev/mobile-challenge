package com.romildosf.currencyconverter.util

object Filters {

    fun filter(searchTerm: String, items: Map<Int, String>): List<Int> {
        val values = mutableListOf<Int>()
        items.entries.forEach {
            if (it.value.toLowerCase().contains(searchTerm.toLowerCase()))
                values.add(it.key)
        }
        return values
    }

}