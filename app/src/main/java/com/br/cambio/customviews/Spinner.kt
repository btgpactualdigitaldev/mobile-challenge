package com.br.cambio.customviews

import android.content.Context
import android.content.ContextWrapper
import android.content.res.TypedArray
import android.text.TextUtils
import android.util.AttributeSet
import android.view.View
import androidx.fragment.app.FragmentActivity
import com.br.cambio.R
import com.br.cambio.customviews.FormItem.Companion.FIELD_TYPE_SPINNER

class Spinner @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : FormField(context, attrs, defStyleAttr) {

    enum class SpinnerType(val type: Int) {
        NONE(0),
        CURRENCY(1),
        FOREIGN_COUNTRIES(2),
        ISSUING_AUTHORITY(3),
        MARITAL_STATUS(4),
        PATRIMONY_ORIGIN(5),
        STATES(6),
        INCOME_ORIGIN(7),
        OCCUPATION(8),
        SCHOLARITY(9),
        STATES_DATA_PROFESSIONAL(10),
        INCOME_ORIGIN_SPI(11),
        STATES_UF_EMISSION_RG(12),
        STATES_UF_EMISSION_RNE(13),
        STATES_UF_EMISSION_CNH(14),
        BANKS(15),
        COUNTRIES(16);
    }

    var spinnerType: SpinnerType? = null
    var spinnerList: List<DialogSpinnerModel>? = null

    /** Determina o valor que será enviado para a API */
    internal var textKey: String? = ""

    internal var textValue: String? = ""

    private var listener: ((DialogSpinnerModel) -> Unit)? = null

    override fun setupStyleables(attrs: AttributeSet?) {
        super.setupStyleables(attrs)
        context.theme.obtainStyledAttributes(
            attrs,
            R.styleable.Spinner,
            0, 0
        ).apply {
            try {
                spinnerType = getTypeFromStylleable()
            } finally {
                recycle()
            }
        }
    }

    private fun TypedArray.getTypeFromStylleable(): SpinnerType {

        return when (getInteger(R.styleable.Spinner_spinnerType, SpinnerType.NONE.type)) {
            SpinnerType.CURRENCY.type -> SpinnerType.CURRENCY
            SpinnerType.FOREIGN_COUNTRIES.type -> SpinnerType.FOREIGN_COUNTRIES
            SpinnerType.ISSUING_AUTHORITY.type -> SpinnerType.ISSUING_AUTHORITY
            SpinnerType.MARITAL_STATUS.type -> SpinnerType.MARITAL_STATUS
            SpinnerType.PATRIMONY_ORIGIN.type -> SpinnerType.PATRIMONY_ORIGIN
            SpinnerType.STATES.type -> SpinnerType.STATES
            SpinnerType.INCOME_ORIGIN.type -> SpinnerType.INCOME_ORIGIN
            SpinnerType.INCOME_ORIGIN_SPI.type -> SpinnerType.INCOME_ORIGIN_SPI
            SpinnerType.OCCUPATION.type -> SpinnerType.OCCUPATION
            SpinnerType.SCHOLARITY.type -> SpinnerType.SCHOLARITY
            SpinnerType.STATES_DATA_PROFESSIONAL.type -> SpinnerType.STATES_DATA_PROFESSIONAL
            SpinnerType.STATES_UF_EMISSION_RG.type -> SpinnerType.STATES_UF_EMISSION_RG
            SpinnerType.STATES_UF_EMISSION_RNE.type -> SpinnerType.STATES_UF_EMISSION_RNE
            SpinnerType.STATES_UF_EMISSION_CNH.type -> SpinnerType.STATES_UF_EMISSION_CNH
            SpinnerType.BANKS.type -> SpinnerType.BANKS
            SpinnerType.COUNTRIES.type -> SpinnerType.COUNTRIES
            else -> SpinnerType.NONE
        }
    }

    override fun setupView(isSpinner: Boolean?) {
        super.setupView(isSpinner = true)
        setFieldType()
        setSpinnerChevron()
        setSpinnerClickListener()
        setOnSpinnerChangeListener()
    }

    /**
     * Reseta o Spinner, limpando o texto do editText e os valores da api
     */
    fun clear() {
        setText(null)
        setSpinnerKey(null)
    }

    private fun setFieldType() {
        fieldType = FIELD_TYPE_SPINNER
    }

    private fun setSpinnerChevron() {
        editText?.apply {
            setCompoundDrawablesWithIntrinsicBounds(
                0,
                0,
                R.drawable.ic_accordion_fechado,
                0
            )
            compoundDrawablePadding = 24
            setPadding(paddingLeft, paddingTop, context.dpToInt(12), paddingBottom)
            ellipsize = TextUtils.TruncateAt.END
        }
    }

    private fun Context.dpToInt(dp: Int): Int {
        return (dp * resources.displayMetrics.density).toInt()
    }

    private fun setSpinnerClickListener() {
        setOnFieldClickListener {
            clearCurrentFocus()
            showDialogSpinner()
        }
    }

    private fun clearCurrentFocus() {
        ((context as ContextWrapper).baseContext as FragmentActivity)?.currentFocus?.clearFocus()
    }

    private fun showDialogSpinner() {
        listener?.let { listener ->
            val fragmentManager = ((context as ContextWrapper).baseContext as FragmentActivity).supportFragmentManager
            spinnerList?.let {
                DialogSpinner.createDialog(
                    spinnerList = it as ArrayList<DialogSpinnerModel>,
                    listener = listener
                ).show(fragmentManager, null)
            } ?: run {
                val list = getList()
                list?.let { enum ->
                    if (!DialogSpinner.isShowing) {
                        DialogSpinner.createDialog(
                            dialogSpinnerEnum = enum,
                            listener = listener
                        ).show(fragmentManager, null)
                    }
                }
            }
        }
    }

    private fun setOnSpinnerChangeListener(listener: ((DialogSpinnerModel) -> Unit)? = null) {
        this.listener = { dialogSpinnerModel: DialogSpinnerModel ->
            setText(dialogSpinnerModel.nome)
            setSpinnerKey(dialogSpinnerModel.codigo)
            listener?.invoke(dialogSpinnerModel)
            refocusSpinner()
        }
    }

    private fun refocusSpinner() {
        isFocusable = true
        requestFocus()
        post {
            isFocusable = false
        }
    }

    override fun setText(text: String?, filterByCode: Boolean) {
        val helper = DialogSpinnerHelper()

        spinnerList?.let {
            helper.filterList(it, text)
        }?.firstOrNull()?.let {
            if (!text.isNullOrBlank()) {
                setSpinnerKey(it.codigo)
                setSpinnerValue(it.nome)
                super.setText(it.nome, filterByCode)
            }
        } ?: run {
            getList()?.let {
                helper.createSpinnerList(it)
            }?.let {
                helper.filterList(it, text)
            }?.firstOrNull()?.let {
                if (!text.isNullOrBlank()) {
                    setSpinnerKey(it.codigo)
                    setSpinnerValue(it.nome)
                    super.setText(it.nome, filterByCode)
                }
            }
        }
    }

    fun setCustomSpinnerList(spinnerList: List<DialogSpinnerModel>) {
        this.spinnerList = spinnerList
    }

    private fun getList(): DialogSpinnerEnum? {
        return when (spinnerType) {
            SpinnerType.CURRENCY -> DialogSpinnerEnum.CURRENTY
            else -> DialogSpinnerEnum.CURRENTY
        }
    }

    private fun setSpinnerKey(text: String?) {
        textKey = text
    }

    private fun setSpinnerValue(text: String?) {
        textValue = text
    }
}