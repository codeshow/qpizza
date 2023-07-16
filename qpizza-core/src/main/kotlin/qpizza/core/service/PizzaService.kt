package qpizza.core.service

import jakarta.enterprise.context.ApplicationScoped

@ApplicationScoped
class PizzaService {
    fun getPizza(): String {
        return "Pizza"
    }
}