package br.com.tiago.conversormoedas.data

interface ConversionRepository {
    fun getRates(currency: String, conversionResultsCallback: (result: ConversionResult) -> Unit)
}