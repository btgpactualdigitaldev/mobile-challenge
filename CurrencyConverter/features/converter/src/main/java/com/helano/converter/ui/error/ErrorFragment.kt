package com.helano.converter.ui.error

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.navArgs
import com.helano.converter.R
import com.helano.converter.databinding.FragmentErrorBinding
import com.helano.shared.enums.Error
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class ErrorFragment : Fragment() {
    private lateinit var binding: FragmentErrorBinding
    private val args: ErrorFragmentArgs by navArgs()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            inflater, R.layout.fragment_error, container, false
        )
        return binding.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        setClickListener()
        handleNavArgs()
    }

    private fun setClickListener() {
        binding.leaveButton.setOnClickListener { activity?.finishAffinity(); }
    }

    private fun handleNavArgs() {
        if (args.error == Error.SERVER) {
            binding.errorTitle.text = getString(R.string.error_api_server_title)
            binding.message2.text = getString(R.string.error_api_server_message)
            binding.errorImage.setImageResource(R.drawable.ic_cloud_error)
        } else {
            binding.errorTitle.text = getString(R.string.error_connection_title)
            binding.message2.text = getString(R.string.error_connection_message)
            binding.errorImage.setImageResource(R.drawable.ic_connection_error)
        }
    }
}