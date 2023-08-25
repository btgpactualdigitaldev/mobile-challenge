package br.com.btg.mobile.challenge.helper

import android.content.Context
import org.jetbrains.annotations.TestOnly

@TestOnly
fun getJsonFromAssetsOrResources(context: Context, fileName: String): String {
    return try {
        context.assets.open(fileName).bufferedReader().readText()
    } catch (ex: Exception) {
        fileName::javaClass::class.java.classLoader?.getResource(fileName)?.readText()
            ?: throw IllegalArgumentException("Invalid json")
    }
}
