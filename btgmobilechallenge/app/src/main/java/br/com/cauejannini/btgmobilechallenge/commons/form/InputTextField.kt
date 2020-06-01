package br.com.cauejannini.btgmobilechallenge.commons.form

import android.content.Context
import android.text.Editable
import android.text.InputType
import android.text.TextWatcher
import android.text.method.PasswordTransformationMethod
import android.util.AttributeSet
import android.util.TypedValue
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View.OnFocusChangeListener
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import android.widget.LinearLayout
import br.com.cauejannini.btgmobilechallenge.R
import br.com.cauejannini.btgmobilechallenge.commons.form.Form.Validatable
import br.com.cauejannini.btgmobilechallenge.commons.form.textwatchers.ValidatorTextWatcher.WatchableField
import br.com.cauejannini.btgmobilechallenge.commons.form.validators.ValidationResult
import br.com.cauejannini.btgmobilechallenge.commons.form.validators.Validator

class InputTextField(context: Context?, attrs: AttributeSet?) : LinearLayout(context, attrs), WatchableField, Validatable {

    override lateinit var editText: EditText

    var text: String?
        get() = editText.text.toString()
        set(text) {
            editText.setText(text)
        }

    var hint: String?
        get() = editText.text.toString()
        set(hint) {
            editText.hint = hint
        }

    var inputType = 0
    var imeOptions = 0
    var customTextAlignment = 0
    var maxLines = 0
    var textSize = 0f
    var textWatcher: TextWatcher? = null
    var myValidator: Validator? = null
    var afterTextChangedListener: AfterTextChangedListener? = null

    override var form: Form? = null

    var onEditTextFocusChangeValidator = OnFocusChangeListener { view, isFocused ->
        if (isFocused) {
            onFocused()
        } else {
            onUnfocused()
            val imm = getContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            imm.hideSoftInputFromWindow(view.windowToken, 0)
        }
    }

    init {

        val child = LayoutInflater.from(context).inflate(R.layout.field_input_text, this, true)
        editText = child.findViewWithTag("et")

        initAttrs(attrs)

        if (inputType != -1) {
            editText.inputType = inputType or InputType.TYPE_TEXT_FLAG_MULTI_LINE or InputType.TYPE_TEXT_VARIATION_LONG_MESSAGE
            if (inputType == InputType.TYPE_TEXT_VARIATION_PASSWORD) {
                editText.transformationMethod = PasswordTransformationMethod.getInstance()
            }
        }

        editText.imeOptions = imeOptions

        editText.setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize)

        if (maxLines > 0) editText.maxLines = maxLines

        editText.gravity = Gravity.TOP or customTextAlignment

        editText.onFocusChangeListener = onEditTextFocusChangeValidator

        if (textWatcher == null) {
            editText.addTextChangedListener(object : TextWatcher {
                override fun beforeTextChanged(charSequence: CharSequence, i: Int, i1: Int, i2: Int) {}

                override fun onTextChanged(charSequence: CharSequence, i: Int, i1: Int, i2: Int) {}

                override fun afterTextChanged(editable: Editable) {
                    this@InputTextField.afterTextChanged(true, editable.toString())
                }
            })
        }
    }

    private fun initAttrs(attrs: AttributeSet?) {

        val typedArray = context.obtainStyledAttributes(attrs, R.styleable.InputTextField)

        hint = typedArray.getString(R.styleable.InputTextField_hint)
        inputType = typedArray.getInt(R.styleable.InputTextField_inputType, -1)
        textSize = typedArray.getDimension(R.styleable.InputTextField_textSize, resources.getDimension(R.dimen.ts))
        customTextAlignment = typedArray.getInt(R.styleable.InputTextField_textAlignment, Gravity.START)
        maxLines = typedArray.getInt(R.styleable.InputTextField_maxLines, -1)
        imeOptions = typedArray.getInt(R.styleable.InputTextField_imeOptions, EditorInfo.IME_ACTION_NEXT)

        typedArray.recycle()
    }

    override fun setEnabled(enabled: Boolean) {
        if (enabled) {
            editText.isEnabled = true
            editText.alpha = 1f
        } else {
            editText.isEnabled = false
            editText.alpha = .5f
        }
    }


    override val isValid: Boolean
        get() = !text!!.trim { it <= ' ' }.isEmpty()

    override fun afterTextChanged(valid: Boolean, text: String) {
        runValidation(text, false)
        if (afterTextChangedListener != null) afterTextChangedListener!!.afterTextChanged(text)
    }

    fun runValidation(text: String?, reflectLayout: Boolean) {
        val validationResult = if (myValidator != null) myValidator!!.validate(text) else ValidationResult(true, "")

        if (text!!.trim { it <= ' ' }.isEmpty() || !reflectLayout) {
            layoutNeutral()
        } else {
            if (validationResult!!.isValid) {
                layoutValid()
            } else {
                layoutError(validationResult.getMessage())
            }
        }
        form?.validadeReceiver(validationResult!!.isValid)
    }

    private fun layoutNeutral() {
        editText.setTextColor(resources.getColor(R.color.white))
    }

    private fun layoutError(message: String) {
        editText.setTextColor(resources.getColor(R.color.red))
        editText.error = message
    }

    private fun layoutValid() {
        editText.setTextColor(resources.getColor(R.color.white))
    }

    fun setValidator(validationInterface: Validator?) {
        myValidator = validationInterface
        runValidation(text, true)
    }

    fun showErrorOnFocusLost(shouldShow: Boolean) {
        if (shouldShow) {
            editText.onFocusChangeListener = onEditTextFocusChangeValidator
        } else {
            editText.onFocusChangeListener = null
        }
    }

    fun setCustomTextWatcher(textWatcher: TextWatcher?) {
        if (textWatcher != null) {
            this.textWatcher = textWatcher
            editText.addTextChangedListener(this.textWatcher)
        } else {
            editText.removeTextChangedListener(this.textWatcher)
            this.textWatcher = null
        }
    }

    private fun onFocused() {
        layoutNeutral()
    }

    private fun onUnfocused() {
        runValidation(text, true)
    }

    interface AfterTextChangedListener {
        fun afterTextChanged(text: String)
    }
}