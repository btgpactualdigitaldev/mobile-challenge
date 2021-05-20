package com.br.mobilechallenge.helper

import com.br.mobilechallenge.model.MappingObject

interface ListMap {

    fun getCurrencyValues(
        char: String,
        arrayName: ArrayList<MappingObject>,
        arrayCurrency: ArrayList<MappingObject>
    ): Double {

        val key = searchKeys(char, arrayName)
        val value = searchValues(key, arrayCurrency)

        return value as Double
    }


    fun searchValues(char: Any, array: ArrayList<MappingObject>, type: String = "double"): Any {

        var r: Any? = null
        array.forEach {

            when (type) {

                "double" -> it.value as Double
                "string" -> it.value as String
            }

            if (it.key == char.toString()) {

                r = it.value
            }

        }
        return r!!
    }

    fun searchKeys(char: String, array: ArrayList<MappingObject>): String {

        var r: String = ""
        array.forEach {

            if (it.value == char) {

                r = it.key
            }

        }

        return r
    }

    fun toString(list: List<Any?>): List<String>{

        val r = mutableListOf<String>()

        list.forEach {

            r.add(it.toString())
        }
        return r
    }



    fun getValues(array: ArrayList<MappingObject>): List<Any?> {

        var valuesList = mutableListOf<Any?>()
        array.forEach { valuesList.add(it.value) }

        return valuesList.toList()
    }

    fun getKeys(array: ArrayList<MappingObject>, n: Int = 3): List<String> {

        var keyList = mutableListOf<String>()
        array.forEach { keyList.add(it.key.takeLast(n)) }

        return keyList.toList()
    }

    fun mapToList(map: Map<String, Any?>): ArrayList<MappingObject> {

        val list = arrayListOf<MappingObject>()
        map.forEach { (key, value) -> list.add(MappingObject(key, value)) }

        return list

    }

    fun mapToQuoteList(map: Map<String, Any>): ArrayList<MappingObject> {

        val currencyList = arrayListOf<MappingObject>()
        map.forEach { (key, value) -> currencyList.add(MappingObject(key.takeLast(3), value)) }

        return currencyList

    }
}