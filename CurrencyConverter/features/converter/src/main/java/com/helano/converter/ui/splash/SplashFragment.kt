package com.helano.converter.ui.splash

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.observe
import androidx.navigation.Navigation
import com.helano.converter.R
import com.helano.converter.databinding.FragmentSplashBinding
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class SplashFragment : Fragment() {

    private lateinit var binding: FragmentSplashBinding
    private val viewModel by viewModels<SplashViewModel>()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            inflater, R.layout.fragment_splash, container, false
        )
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel.start()
        setNavigation(view)
    }

    private fun setNavigation(view: View) {
        viewModel.refreshResult.observe(viewLifecycleOwner) {
            if (it.success) {
                Navigation.findNavController(view)
                    .navigate(SplashFragmentDirections.actionStartConverter())
            } else {
                Navigation.findNavController(view)
                    .navigate(
                        SplashFragmentDirections.actionError(it.error!!)
                    )
            }
        }
    }
}
