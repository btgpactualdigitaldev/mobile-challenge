package io.felipeandrade.currencylayertest.ui

import android.content.Context
import android.view.KeyEvent
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import android.widget.TextView

 fun EditText.setOnFinishTyping(function: () -> Unit) {
    setOnEditorActionListener(TextView.OnEditorActionListener { _, actionId, event ->
        if (actionId == EditorInfo.IME_ACTION_SEARCH ||
            actionId == EditorInfo.IME_ACTION_DONE ||
            event != null &&
            event.action == KeyEvent.ACTION_DOWN &&
            event.keyCode == KeyEvent.KEYCODE_ENTER
        ) {

            if (event == null || !event.isShiftPressed) {
                // the user is done typing.

                val imm =
                    context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                imm.hideSoftInputFromWindow(windowToken, 0)

                clearFocus()

                function.invoke()
                return@OnEditorActionListener true
            }
        }
        false
    })
}