package br.com.andreldsr.btgcurrencyconverter.infra.response

data class CurrencyListResponse(val success: Boolean, val currencies: Map<String, String>?, val error: Error?) {}