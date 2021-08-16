package com.br.cambio.customviews

import com.google.gson.Gson

class JsonUtil {

    companion object {
        private var singleton: JsonUtil? = null

        fun getInstance(): JsonUtil {
            if (null == singleton) {
                singleton = JsonUtil()
            }
            return singleton as JsonUtil
        }
    }

    fun <T> convertJsonFile(clazz: Class<T>, filePath: String): T {
        return Gson().fromJson(readStringFile(filePath), clazz)
    }

    private fun readStringFile(fileName: String): String {
        val inputStream = javaClass.classLoader.getResourceAsStream(fileName)
        if (null != inputStream) {
            val s = java.util.Scanner(inputStream).useDelimiter("\\A")
            if (s.hasNext()) {
                return s.next()
            }
        }
        return ""
    }

}