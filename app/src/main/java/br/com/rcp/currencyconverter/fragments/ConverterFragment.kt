package br.com.rcp.currencyconverter.fragments

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.OnBackPressedCallback
import androidx.activity.addCallback
import androidx.core.os.bundleOf
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import br.com.rcp.currencyconverter.R
import br.com.rcp.currencyconverter.database.entities.Currency
import br.com.rcp.currencyconverter.databinding.FragmentConverterBinding
import br.com.rcp.currencyconverter.fragments.base.BaseFragment
import br.com.rcp.currencyconverter.fragments.viewmodels.ConverterViewModel

class ConverterFragment : BaseFragment<FragmentConverterBinding, ConverterViewModel>() {
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binder          = DataBindingUtil.inflate(inflater, R.layout.fragment_converter, container, false)
        service         = ViewModelProvider(this)[ConverterViewModel::class.java]
        binder.service  = service
        return binder.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        setObservers()
        binder.lifecycleOwner = this

        findNavController().currentBackStackEntry?.savedStateHandle?.getLiveData<Currency>("source")?.observe(viewLifecycleOwner) {
            binder.source = it
        }

        findNavController().currentBackStackEntry?.savedStateHandle?.getLiveData<Currency>("target")?.observe(viewLifecycleOwner) {
            binder.target = it
        }

        super.onViewCreated(view, savedInstanceState)
    }

    private fun setObservers() {
        service.click.observe(viewLifecycleOwner, {
            if (it != 0) {
                if (it == R.id.target_cur) {
                    findNavController().navigate(R.id.toSelectionList, bundleOf("identifier" to "target"))
                    service.click.value = 0
                }

                if (it == R.id.source_cur) {
                    findNavController().navigate(R.id.toSelectionList, bundleOf("identifier" to "source"))
                    service.click.value = 0
                }
            }
        })

        service.error.observe(viewLifecycleOwner, {
            if (it) {
                Toast.makeText(requireContext(), "Preencha os campos!", Toast.LENGTH_SHORT).show()
                service.error.value = false
            }
        })
    }
}