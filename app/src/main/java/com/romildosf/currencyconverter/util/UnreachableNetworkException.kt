package com.romildosf.currencyconverter.util

object UnreachableNetworkException: NetworkCallException(ErrorCodes.CURRENCY_NOT_FOUND, "Error on network call")