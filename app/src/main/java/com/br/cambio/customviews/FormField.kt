package com.br.cambio.customviews

import android.content.Context
import android.content.res.TypedArray
import android.util.AttributeSet
import android.widget.EditText
import androidx.appcompat.view.ContextThemeWrapper
import com.br.cambio.R
import com.br.cambio.customviews.FormItem.Companion.FIELD_TYPE_NONE
import com.google.android.material.textfield.TextInputEditText
import com.google.android.material.textfield.TextInputLayout

abstract class FormField @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : TextInputLayout(context, attrs, defStyleAttr),
    FormItem {

    var fieldType: Int = FIELD_TYPE_NONE
    var errorType: Int = 0
    var shouldTagValidationError: Boolean = false
    var isOptional: Boolean = false

    val FONT_REGULAR = 0
    val FONT_LIGHT = 3

    var shouldValidateOnFocusChange: Boolean = true
    var hintFontFamily: Int = FONT_REGULAR
    var textFontFamily: Int = FONT_LIGHT
    var maxLength: Int = 0
    @android.support.annotation.StyleRes
    var style: Int = R.style.EditTextMain

    init {
        setupStyleables(attrs)
        setupView()
    }

    internal open fun setupStyleables(attrs: AttributeSet?) {
        getStyledAttributes(attrs).apply {
            try {
                fieldType = getInteger(R.styleable.FormField_fieldType, FIELD_TYPE_NONE)
                errorType = getInteger(R.styleable.FormField_errorType, 0)
                shouldValidateOnFocusChange = getBoolean(R.styleable.FormField_shouldValidateOnFocusChange, true)
                hintFontFamily = getInteger(R.styleable.FormField_hintFontFamily, FONT_LIGHT)
                textFontFamily = getInteger(R.styleable.FormField_textFontFamily, FONT_REGULAR)
                style = getResourceId(R.styleable.FormField_editTextStyle, R.style.EditTextMain)
                maxLength = getInteger(R.styleable.FormField_maxLength, 0)
                shouldTagValidationError = getBoolean(R.styleable.FormField_shouldTagValidationError, false)
                isOptional = getBoolean(R.styleable.FormField_isOptional, false)
            } finally {
                recycle()
            }
        }
    }

    private fun getStyledAttributes(attrs: AttributeSet?): TypedArray {
        return context.theme.obtainStyledAttributes(
            attrs,
            R.styleable.FormField,
            0, 0)
    }

    /**
     * Configura a view setando automaticamente todas as configurações necessárias para
     * acessibilidade, tamanho máximo de caracteres, tipo de campo, navegação, fonte, style,
     * tratamento de erros, foco, validação, etc.
     */
    internal open fun setupView(isSpinner: Boolean? = null) {
        addView(createEditText().apply {
            setLayoutParams()
            setSingleLine()
        },0)
    }

    private fun createEditText(): EditText {
        return TextInputEditText(ContextThemeWrapper(context, style), null, 0)
    }

    private fun EditText.setLayoutParams() {
        layoutParams = LayoutParams(
            LayoutParams.MATCH_PARENT,
            LayoutParams.WRAP_CONTENT)
    }

    open fun setText(text: String?, filterByCode: Boolean = false) {
        editText?.setText(text)
    }
}