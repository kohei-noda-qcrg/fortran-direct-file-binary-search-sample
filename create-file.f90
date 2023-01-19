program createfile
    implicit none

    integer(8) :: idx
    real(8) :: x

    x = 0.0
    open (1, file='binaryfile', status='replace', action='write', &
          form='unformatted')

    do idx = 1, 10**7
        x = idx
        write (1) idx, x
    end do
end program createfile
