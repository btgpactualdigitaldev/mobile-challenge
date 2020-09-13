package br.com.rcp.currencyconverter.fragments.base

import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import androidx.transition.TransitionInflater
import br.com.rcp.currencyconverter.R
import br.com.rcp.currencyconverter.fragments.viewmodels.base.BaseViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

abstract class BaseFragment<Binder: ViewDataBinding, Service: BaseViewModel>: Fragment() {
    protected 				val		TAG			= "[${javaClass.canonicalName}]"
    protected	lateinit 	var		binder		: Binder
    protected 	lateinit	var		service		: Service
    private 	lateinit 	var		progress	: AlertDialog

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        sharedElementEnterTransition = TransitionInflater.from(context).inflateTransition(android.R.transition.move)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        setObservers()
        setProgressDialog()
        super.onActivityCreated(savedInstanceState)
    }

    private fun showToastMessage(message: String) {
        CoroutineScope(Dispatchers.Main).launch {
            Toast.makeText(requireContext(), message, Toast.LENGTH_SHORT).show()
        }
    }

    private fun setObservers() {
        service.toast.observe(viewLifecycleOwner,       { showToastMessage(it) })
        service.progress.observe(viewLifecycleOwner,    { if (it) { progress.show() } else { progress.cancel() } })
    }

    private fun setProgressDialog() {
        val		builder		= AlertDialog.Builder(requireContext())
        val		view		= layoutInflater.inflate(R.layout.dialog_loading, null)
        builder.setView(view)
        builder.setCancelable(false)
        progress			= builder.create()
    }
}