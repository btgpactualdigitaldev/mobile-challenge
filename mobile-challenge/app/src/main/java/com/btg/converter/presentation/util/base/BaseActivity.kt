package com.btg.converter.presentation.util.base

import android.app.Dialog
import android.os.Bundle
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import com.btg.converter.presentation.util.dialog.DialogData
import com.btg.converter.presentation.util.extension.consume
import com.btg.converter.presentation.util.extension.observe
import com.btg.converter.presentation.util.extension.showDialog
import com.btg.converter.presentation.util.navigation.NavData

abstract class BaseActivity : AppCompatActivity() {

    private var dialog: Dialog? = null

    abstract val baseViewModel: BaseViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        subscribeUi()
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            android.R.id.home -> consume { onBackPressed() }
            else -> super.onOptionsItemSelected(item)
        }
    }

    open fun subscribeUi() {
        baseViewModel.dialog.observe(this, ::onNextDialog)
        baseViewModel.goTo.observe(this, ::onGoTo)
    }

    private fun onNextDialog(dialogData: DialogData?) {
        dialog?.dismiss()
        dialog = dialogData?.let { showDialog(it) }
    }

    private fun onGoTo(navData: NavData?) {
        navData?.navigate(this)
    }
}
