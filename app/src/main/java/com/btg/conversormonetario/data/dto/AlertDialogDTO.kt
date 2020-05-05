package com.btg.conversormonetario.data.dto

data class AlertDialogDTO(
    var title: Int? = 0,
    var message: String? = "",
    var textPositiveButton: Int? = null,
    var actionPositiveButton: (() -> Unit?)? = null
)