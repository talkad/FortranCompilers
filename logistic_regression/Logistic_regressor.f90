module logistic_regression_module
    use loss_module

    type logistic_regressor_type
        real, dimension(:), pointer :: weights
        class(loss_t), pointer :: loss

        contains
            procedure :: feed_forward
    end type 

    interface logistic_regressor_type
        procedure :: constructor
    end interface

    contains

    function constructor(num_features, loss, init_weights)
        class(logistic_regressor_type), pointer :: constructor
        real, dimension(:), target, optional :: init_weights
        real, dimension(:), allocatable, target :: random_array
        integer, intent(in) :: num_features
        class(loss_t), intent(in), target :: loss
        integer :: i
        
        allocate(constructor)

        if (present(init_weights)) then 
            constructor%weights => init_weights
        else
            allocate(random_array(num_features))

            ! fill random weights
            do i = 1, num_features
                random_array(i) = rand()
            end do

            constructor%weights => random_array
            constructor%loss => loss
        end if

    end function


    function feed_forward(this, feature_vec)
        real :: feed_forward
        class(logistic_regressor_type) :: this
        real, pointer, dimension(:) :: feature_vec
        real :: sum = 0
        integer :: i

        ! check validity
        if (size(this%weights) /= size(feature_vec)) then
            feed_forward = -1
            return
        end if

        do i= 1, size(this%weights)
            sum = sum + (feature_vec(i) * this%weights(i))
        end do

        feed_forward = sum
    
    end function feed_forward
        

end module