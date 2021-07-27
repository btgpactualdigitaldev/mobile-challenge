package com.btg.conversormonetario.data.model

import com.btg.conversormonetario.R

data class ItemSpinnerDecoration (
    var icon: Int? = null,
    var background: Int? = null,
    var isTouchable: Boolean? = false,
    var textColor: Int? = null
) {
    fun cardDefault(): ItemSpinnerDecoration {
        this.icon = R.mipmap.ic_launcher
        this.background = R.mipmap.ic_launcher_round
        this.textColor = R.color.darkGray
        this.isTouchable = false
        return this
    }

    fun cardLightBlue(): ItemSpinnerDecoration {
        this.icon = R.mipmap.ic_launcher
        this.background = R.mipmap.ic_launcher_round
        this.textColor = R.color.ice
        this.isTouchable = true
        return this
    }
}