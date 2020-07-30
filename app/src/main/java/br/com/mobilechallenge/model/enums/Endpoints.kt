package br.com.mobilechallenge.model.enums

enum class Endpoints(private val endpoint: String) {
    LIST("/list?access_key={0}"),
    LIVE("/live?access_key={0}&format=1&currencies={1}");

    fun endpoint(): String = endpoint
}