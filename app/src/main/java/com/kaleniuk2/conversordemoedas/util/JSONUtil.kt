package com.kaleniuk2.conversordemoedas.util

import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject


object JSONUtil {
    @Throws(JSONException::class)
    fun toMap(jsonobj: JSONObject): Map<String, Any> {
        val map: MutableMap<String, Any> =
            HashMap()
        val keys = jsonobj.keys()
        while (keys.hasNext()) {
            val key = keys.next()
            var value = jsonobj[key]
            if (value is JSONArray) {
                value =
                    toList(value)
            } else if (value is JSONObject) {
                value =
                    toMap(value)
            }
            map[key] = value
        }
        return map
    }

    @Throws(JSONException::class)
    fun toList(array: JSONArray): List<Any> {
        val list: MutableList<Any> = ArrayList()
        for (i in 0 until array.length()) {
            var value = array[i]
            if (value is JSONArray) {
                value =
                    toList(value)
            } else if (value is JSONObject) {
                value =
                    toMap(value)
            }
            list.add(value)
        }
        return list
    }

}

