package com.btg.convertercurrency.features.util

import java.lang.Exception


class GenericConverterCurrencyException(
    var codeError : Int = 0,
    var mensageError : String
) : Exception(mensageError) {}