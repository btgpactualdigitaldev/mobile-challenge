package com.vald3nir.btg_challenge.extensions

import android.net.Uri
import android.view.animation.Animation
import android.view.animation.LinearInterpolator
import android.view.animation.RotateAnimation
import android.widget.ImageView
import androidx.databinding.BindingAdapter
import com.github.twocoffeesoneteam.glidetovectoryou.GlideToVectorYou
import com.vald3nir.btg_challenge.R

@BindingAdapter(value = ["loadImage"])
fun ImageView.bindingLoadImage(url: String?) = loadImage(url)

fun ImageView.loadImage(url: String?) {
    if (!url.isNullOrBlank()) {
        GlideToVectorYou.init().with(this.context)
            .setPlaceHolder(
                R.drawable.placeholder_image_not_found,
                R.drawable.placeholder_image_not_found
            )
            .load(Uri.parse(url), this)
    } else {
        this.setImageResource(R.drawable.placeholder_image_not_found)
    }
}

fun ImageView.animateRotate90Degrees() {
    val rotate = RotateAnimation(
        0.0f, 180.0f,
        Animation.RELATIVE_TO_SELF, 0.5f,
        Animation.RELATIVE_TO_SELF, 0.5f
    )
    rotate.duration = 500
    rotate.interpolator = LinearInterpolator()
    this.startAnimation(rotate)
}