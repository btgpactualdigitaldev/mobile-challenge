package com.btg.converter.presentation.util.dialog

import com.btg.converter.domain.util.resource.Strings

class DialogData(
    val title: String,
    val message: String,
    val confirmButtonText: String? = null,
    val onConfirm: (() -> Unit)? = null,
    val dismissButtonText: String? = null,
    val onDismiss: (() -> Unit)? = null,
    val cancelable: Boolean? = true
) {
    companion object {

        fun confirm(
            title: String,
            message: String,
            onConfirm: () -> Unit,
            confirmButtonText: String? = null,
            cancelable: Boolean? = true
        ): DialogData {
            return DialogData(title, message, confirmButtonText, onConfirm, null, null, cancelable)
        }

        fun error(
            strings: Strings,
            message: String,
            confirmButtonText: String? = null,
            onConfirm: (() -> Unit)? = null,
            onDismiss: (() -> Unit)? = null,
            cancelable: Boolean? = true
        ): DialogData {
            return DialogData(
                strings.errorTitle,
                message,
                confirmButtonText,
                onConfirm,
                null,
                onDismiss,
                cancelable
            )
        }
    }
}
