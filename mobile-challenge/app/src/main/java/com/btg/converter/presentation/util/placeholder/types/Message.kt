package com.btg.converter.presentation.util.placeholder.types

import com.btg.converter.presentation.util.placeholder.Placeholder

class Message(val message: String) : Placeholder {
    override val progressVisible: Boolean get() = false
    override val visible: Boolean get() = true
    override val buttonVisible: Boolean get() = false
    override val messageVisible: Boolean get() = true
}