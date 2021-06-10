package clcmo.com.btgcurrency.util.extension

import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment

fun Fragment.backButtonView(view: Boolean) {
    (activity as? AppCompatActivity)?.supportActionBar?.setShowHideAnimationEnabled(view)
}
