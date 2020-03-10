package com.eden.btg.activity

import android.annotation.SuppressLint
import android.app.Activity
import android.app.Dialog
import android.view.Window
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.GlideDrawableImageViewTarget
import com.eden.btg.R


class ViewDialog
    (private var activity: Activity) {
    private var dialog: Dialog = Dialog(activity)
    @SuppressLint("ResourceType")
    fun showDialog() {
        dialog = Dialog(activity)
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE)
        dialog.setCancelable(false)
        dialog.setContentView(R.layout.loading_activity)

        val gifImageView: ImageView = dialog.findViewById(R.id.custom_loading_imageView)

        val imageViewTarget =
            GlideDrawableImageViewTarget(gifImageView)

        Glide.with(activity)
            .load(R.drawable.loading)
            .placeholder(R.drawable.loading)
            .centerCrop()
            .crossFade()
            .into(imageViewTarget)

        dialog.show()
    }

    fun hideDialog() {
        this.dialog.dismiss()
    }

}