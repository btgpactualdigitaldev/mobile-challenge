package com.btg.converter.presentation.util.placeholder.types

import com.btg.converter.presentation.util.placeholder.Placeholder

class Action(
    val message: String,
    val buttonText: String,
    val action: () -> Unit
) : Placeholder {
    override val progressVisible: Boolean get() = false
    override val visible: Boolean get() = true
    override val buttonVisible: Boolean get() = true
    override val messageVisible: Boolean get() = true

    fun onActionButtonClicked() {
        action.invoke()
    }
}