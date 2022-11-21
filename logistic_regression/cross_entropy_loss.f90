module cross_entropy_loss_module
    use loss_module

    type, extends(loss_t) :: cross_entropy_t

        contains
        procedure :: compute_loss => compute_cross_entropy_loss
    end type

    contains

    function compute_cross_entropy_loss(this, y, y_hat)
        real :: y, y_hat
        class(cross_entropy_t) :: this
        real :: compute_cross_entropy_loss

        compute_cross_entropy_loss = -(y*log(y_hat) + (1-y)*log(1-y_hat))

    end function

end module