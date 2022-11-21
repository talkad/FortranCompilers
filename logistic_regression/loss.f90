module loss_module

    type, abstract :: loss_t

        contains
            procedure(loss), deferred :: compute_loss
    end type

    abstract interface
        function loss(this, y, y_hat)
            import loss_t
            class(loss_t) :: this
            real :: y, y_hat
            real :: loss
        end function
    end interface

end module