package com.gft.domain.usecases

import com.gft.domain.repository.CurrencyRepository

class GetLabelsUseCase(
    private val repository: CurrencyRepository
) {

    suspend fun execute() = repository.getLabels()

}