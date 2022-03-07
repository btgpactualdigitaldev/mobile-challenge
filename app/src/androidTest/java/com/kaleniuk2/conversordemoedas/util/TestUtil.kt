package com.kaleniuk2.conversordemoedas.util

import androidx.test.platform.app.InstrumentationRegistry
import java.io.IOException
import java.io.InputStream

fun loadData(inFile: String): String? {
    var tContents: String? = ""
    try {
        val stream: InputStream =
            InstrumentationRegistry.getInstrumentation().targetContext.assets.open(inFile)
        val size: Int = stream.available()
        val buffer = ByteArray(size)
        stream.read(buffer)
        stream.close()
        tContents = String(buffer)
    } catch (e: IOException) {
        return ""
    }
    return tContents
}