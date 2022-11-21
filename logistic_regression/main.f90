program main
    use logistic_regression_module
    use cross_entropy_loss_module

    integer :: i
    integer, parameter :: NUM_FEATURES = 5
    type(logistic_regressor_type), pointer :: regressor
    real, pointer, dimension(:) :: feature_vec
    type(cross_entropy_t), allocatable :: loss_func

    allocate(feature_vec(NUM_FEATURES))
    allocate(loss_func)
    regressor => logistic_regressor_type(NUM_FEATURES, loss_func)
    feature_vec = 1

    ! do i=1, NUM_FEATURES 
    !     print *, regressor%weights(i)
    ! end do

    print *, regressor%feed_forward(feature_vec)


end program