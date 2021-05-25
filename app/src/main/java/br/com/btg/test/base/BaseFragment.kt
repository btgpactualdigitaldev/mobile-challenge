package br.com.btg.test.base

import android.view.View
import androidx.fragment.app.Fragment
import com.google.android.material.snackbar.Snackbar

abstract class BaseFragment : Fragment() {

    protected fun showError(message: String?, view: View) {
        message?.let {
            Snackbar.make(
                view,
                it,
                Snackbar.LENGTH_LONG
            ).show()
        }
    }
}