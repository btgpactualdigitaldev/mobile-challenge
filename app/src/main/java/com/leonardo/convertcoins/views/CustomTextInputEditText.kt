package com.leonardo.convertcoins.views

import android.content.Context
import android.util.AttributeSet
import android.view.MotionEvent
import com.google.android.material.textfield.TextInputEditText


class CustomTextInputEditText(context: Context, attrs: AttributeSet) : TextInputEditText(context, attrs) {

    override fun onTouchEvent(event: MotionEvent): Boolean {
        super.onTouchEvent(event)
        when (event.action) {
            MotionEvent.ACTION_DOWN -> return true
            MotionEvent.ACTION_UP -> {
                performClick()
                return true
            }
        }
        return false
    }

    // Because we call this from onTouchEvent, this code will be executed for both
    // normal touch events and for when the system calls this using Accessibility
    override fun performClick(): Boolean {
        super.performClick()
        return true
    }
}