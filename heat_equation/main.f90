
program main
    use heat_equation_abstract
    use heat_equation
    use heat_map

    integer :: i, j, num_threads
    integer, parameter :: N = 50005
    class(heat_map_t), pointer :: map
    class(heat_equation_abstract_t), pointer :: alg
    real, dimension(:,:), pointer :: arr
    real, dimension(:,:), pointer :: updated_arr
    character(len=32) :: arg

    allocate(arr(N,N))

    call get_command_argument(1,arg)
    read(arg,*)  num_threads

    ! init heat map
    do j = 1, N
        do i = 1, N
            arr(i, j) = 100 / (((i-N/2 - 1)**2 + (j-N/2 - 1)**2) + 1)
        end do
    end do

    alg => heat_equation_t(0.2, 0.7)
    map => heat_map_t(arr)

    call map%set_alg(alg)
    updated_arr => map%calc_heat(num_threads)

    ! ! print heat map
    ! do i = 1, N
    !     do j = 1, N
    !         write(*, fmt="(F10.2, a)", advance="no") updated_arr(i,j), " "
    !     end do
    !     print*, ""
    ! end do

end program


! speedup = 11.938091123476624 / 1.4134987667202950 = 8.445