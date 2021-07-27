package com.btg.teste.conversion

import android.view.View
import androidx.navigation.findNavController

class ConversionRouter(private val view: View) {

    fun popBackStack() = view.findNavController().popBackStack()

}