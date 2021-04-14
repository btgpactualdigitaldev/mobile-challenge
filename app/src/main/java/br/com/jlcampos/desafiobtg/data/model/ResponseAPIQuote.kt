package br.com.jlcampos.desafiobtg.data.model

data class ResponseAPIQuote (
    var success: Boolean,
    var quote: Quote?,
    var calc: String,
    var errorApi: ErrorApi?
)