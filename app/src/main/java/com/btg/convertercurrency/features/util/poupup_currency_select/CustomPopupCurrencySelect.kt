package com.btg.convertercurrency.features.util.poupup_currency_select

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.graphics.Point
import android.graphics.drawable.ColorDrawable
import android.text.Editable
import android.text.TextWatcher
import android.view.Gravity
import android.widget.LinearLayout
import android.widget.PopupWindow
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.MutableLiveData
import com.btg.convertercurrency.BR
import com.btg.convertercurrency.R
import com.btg.convertercurrency.databinding.PopupCurrencySelectBinding
import com.btg.convertercurrency.features.base_entity.CurrencyItem
import com.btg.convertercurrency.features.util.default
import com.btg.convertercurrency.features.util.dimBehind

open class CustomPopupCurrencySelect(private val context: Context) : PopupWindow(context) {

    var onClickCallback: (CurrencyItem) -> Unit = {}

    private val customPopupCurrencySelectAdapter by lazy {
        CustomPopupCurrencySelectAdapter{
            onClickCallback(it)
            dismiss()
        }
    }

    fun display(listCurrencyItem: List<CurrencyItem>) {

        val activity = context as Activity

        val layout = (DataBindingUtil
            .inflate(
                activity.layoutInflater,
                R.layout.popup_currency_select,
                null,
                false
            ) as PopupCurrencySelectBinding).apply {

            rvCurrencySelect.run {
                customPopupCurrencySelectAdapter.setData(listCurrencyItem)
                adapter = customPopupCurrencySelectAdapter
            }

            etSearch.addTextChangedListener(
                object : TextWatcher {
                    override fun afterTextChanged(p0: Editable?) {}

                    override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {}

                    override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                        customPopupCurrencySelectAdapter.setFilterText(p0.toString())
                    }
                }
            )

            setVariable(BR.poupUpCurrecySelect, this@CustomPopupCurrencySelect)
        }.root

        val display = activity.windowManager.defaultDisplay
        val size = Point()
        display.getSize(size)
        val windowWidth = size.x

        contentView = layout
        width =
            windowWidth - context.resources.getDimensionPixelSize(R.dimen.default_margin_scream) * 2
        height = LinearLayout.LayoutParams.WRAP_CONTENT
        isFocusable = true
        isOutsideTouchable = true
        setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))

        showAtLocation(layout, Gravity.CENTER, 0, 0)

        dimBehind()
        update()
    }
}