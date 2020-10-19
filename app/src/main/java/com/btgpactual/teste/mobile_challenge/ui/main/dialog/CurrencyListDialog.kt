package com.btgpactual.teste.mobile_challenge.ui.main.dialog

import android.app.Dialog
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.KeyEvent
import android.view.MotionEvent
import android.view.View
import android.view.Window
import android.widget.AdapterView
import android.widget.SearchView
import android.widget.Toast
import androidx.fragment.app.FragmentManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.btgpactual.teste.mobile_challenge.R
import com.btgpactual.teste.mobile_challenge.data.local.entities.CurrencyEntity
import com.btgpactual.teste.mobile_challenge.ui.main.ISelectedCurrency
import com.btgpactual.teste.mobile_challenge.ui.main.TypeCurrency
import dagger.android.support.DaggerDialogFragment
import kotlinx.android.synthetic.main.dialog_list_currency.*

/**
 * Created by Carlos Souza on 17,October,2020
 */
class CurrencyListDialog() : DaggerDialogFragment() {

    private val TAG = "CurrencyListDialog"

    lateinit var adapterListener: ISelectedCurrency

    lateinit var type: TypeCurrency

    companion object {
        fun newInstance() = CurrencyListDialog()
    }

    lateinit var currencyList: MutableList<CurrencyEntity>

    lateinit var currencyAdapter: CurrencyListAdapter

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        var dialog = super.onCreateDialog(savedInstanceState)
        dialog.window!!.requestFeature(Window.FEATURE_NO_TITLE)
        dialog.setContentView(R.layout.dialog_list_currency)

        dialog.setCancelable(false)
        dialog.setCanceledOnTouchOutside(false)
        dialog.setOnKeyListener { dialog, keyCode, event ->
            if (keyCode == KeyEvent.KEYCODE_POWER) {
                val closeDialog = Intent(Intent.ACTION_CLOSE_SYSTEM_DIALOGS)
                this.requireActivity().sendBroadcast(closeDialog)
            }
            false
        }

        currencyAdapter = CurrencyListAdapter(currencyList, adapterListener, type)

        dialog.rvCurrencyList.layoutManager = LinearLayoutManager(context)
        dialog.rvCurrencyList.adapter = currencyAdapter

        dialog.svCurrencyList.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(p0: String?): Boolean {
                return false
            }

            override fun onQueryTextChange(p0: String?): Boolean {
                currencyAdapter.filter.filter(p0)
                return false
            }

        })

        return dialog
    }

    fun setList(list: MutableList<CurrencyEntity>) {
        currencyList = list
    }

    fun setListener(listener: ISelectedCurrency, typeCurrency: TypeCurrency) {
        adapterListener = listener
        type = typeCurrency
    }

    override fun show(manager: FragmentManager, tag: String?) {
        try {
            val ft = manager.beginTransaction()
            ft.add(this, tag)
            ft.commitAllowingStateLoss()
        } catch (ex: Exception) {
            Log.e(TAG, "show", ex)
        }
    }
}