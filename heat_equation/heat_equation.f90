module heat_equation
    use heat_equation_abstract

    type, extends(heat_equation_abstract_t) :: heat_equation_t
        private
        real :: c1, c2
        contains
            procedure :: Calc_heat_equation => Calc_heat_equation
    end type

    interface heat_equation_t
        procedure init
    end interface

    contains

    function Calc_heat_equation(this, matrix, i, j)
        implicit None
        class(heat_equation_t) :: this
        real, dimension(:,:), pointer :: matrix
        integer, intent(in) :: i, j
        real :: Calc_heat_equation

        Calc_heat_equation = matrix(i, j) + &
                             (matrix(i, j-1) + matrix(i, j+1) - this%c1*matrix(i, j)) + &
                             (matrix(i-1, j) + matrix(i+1, j) - this%c2*matrix(i, j))
    end function

    function init(c1, c2)
        implicit None
        class(heat_equation_t), pointer :: init
        real, intent(in) :: c1, c2

        allocate(init)
        init%c1 = c1
        init%c2 = c2
    end function

end module