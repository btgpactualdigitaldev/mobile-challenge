package com.btg.conversormonetario.view.fragment

import android.app.Dialog
import android.view.View
import android.view.View.inflate
import androidx.core.content.ContextCompat
import com.btg.conversormonetario.R
import com.btg.conversormonetario.view.adapter.SpinnerAdapter
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import kotlinx.android.synthetic.main.custom_spinner.view.*

open class BottomSheetOptionFragment(
    var adapter: SpinnerAdapter,
    var itemSelected: (String) -> Unit = { }
) : BottomSheetDialogFragment() {

    override fun setupDialog(dialog: Dialog, style: Int) {
        val contentView = inflate(context, R.layout.custom_spinner, null)
        dialog.setContentView(contentView)
        (contentView.parent as View).setBackgroundColor(
            ContextCompat.getColor(
                context!!,
                android.R.color.transparent
            )
        )

        contentView.tvwCustomSpinnerTitle.text = context!!.getString(R.string.ordenar_lista_por)

        contentView.lsvCustomSpinnerOption.adapter = adapter

        adapter.reasonPosition = {
            itemSelected.invoke(it)
        }
    }
}