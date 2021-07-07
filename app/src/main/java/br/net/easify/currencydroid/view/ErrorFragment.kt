package br.net.easify.currencydroid.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import br.net.easify.currencydroid.R
import kotlinx.android.synthetic.main.fragment_error.*

class ErrorFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_error, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        tryAgainButton.setOnClickListener(View.OnClickListener {
            val action = ErrorFragmentDirections.actionBackHome(0)
            Navigation.findNavController(it).navigate(action)
        })
    }
}