module heat_equation_abstract

    type, abstract :: heat_equation_abstract_t

    contains
        procedure(Calc_eqaution), deferred :: Calc_heat_equation
    end type

    abstract interface
        function Calc_eqaution(this, matrix, i, j)
            import heat_equation_abstract_t
            class(heat_equation_abstract_t) :: this
            real, dimension(:,:), pointer :: matrix
            integer, intent(in) :: i, j
            real :: Calc_eqaution
        end function
    end interface

end module
