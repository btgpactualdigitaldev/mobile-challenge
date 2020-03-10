package com.eden.btg.model

import java.io.Serializable

data class Moeda(val sigla: String, val nome: String, var vrDollar: Double = 0.0): Serializable
