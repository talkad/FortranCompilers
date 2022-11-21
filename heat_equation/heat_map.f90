module heat_map
    use heat_equation_abstract
    use omp_lib

    type heat_map_t
        private
            real, dimension(:,:), pointer :: map_arr
            class(heat_equation_abstract_t), pointer :: heat_alg => null()
        contains
            procedure :: set_alg
            procedure :: calc_heat
    end type

    interface heat_map_t
        procedure constructor
    end interface

    contains

    subroutine set_alg(this, alg)
        implicit None
        class(heat_map_t) :: this
        class(heat_equation_abstract_t), target :: alg

        this%heat_alg => alg
    end subroutine

    function calc_heat(this, num_threads)
        implicit None
        class(heat_map_t) :: this
        real, dimension(:,:), pointer :: calc_heat
        integer :: i, j, num_threads
        real*8 :: time

        if (.not. associated(this%heat_alg)) then 
            print* , 'need to set the relevant algorithm!'
            call exit(2)
        end if

        allocate(calc_heat(size(this%map_arr, dim=1), size(this%map_arr, dim=2)))

        call omp_set_dynamic(.false.)
        call omp_set_num_threads(num_threads)
        time = omp_get_wtime()

        !$omp parallel shared(calc_heat)
        !$omp do
        do j = 2, size(calc_heat, dim=2) - 1
            do i = 2, size(calc_heat, dim=1) - 1
                calc_heat(i, j) = this%heat_alg%Calc_heat_equation(this%map_arr, i, j)
            end do
        end do
        !$omp end do
        !$omp end parallel

        open(1, file = 'exe_time.log', status='old', position="append", action="write")
        write(1,*) omp_get_wtime() - time
        close(1)
    end function

    function constructor(map)
        implicit None
        class(heat_map_t), pointer :: constructor
        real, dimension(:,:), target :: map

        allocate(constructor)
        
        constructor%map_arr => map
    end function

end module