package br.com.andreldsr.btgcurrencyconverter.infra.response

data class QuoteListResponse(val success: Boolean, val quotes: Map<String, String>) {}