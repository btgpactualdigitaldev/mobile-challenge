package com.br.cambio.utils

import com.br.cambio.data.model.Exchange

object Extensions{
    fun isNullOrEmpty(data: Exchange?): Boolean {
        return data == null
    }
}