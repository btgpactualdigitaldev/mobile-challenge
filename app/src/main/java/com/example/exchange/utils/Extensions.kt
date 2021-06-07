package com.example.exchange.utils

fun String.coinFormatted(): String {
    return String.format("%,.2f", this.toDouble())
}