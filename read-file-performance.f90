program readfileperf
    implicit none

    ! 1. Declare variables
    real(8) :: start_time, end_time, x
    character(len=100) :: fname = "binaryfile"
    integer(4) :: funit = 100
    integer(8) :: idx, ios, seek
    integer(8) :: search = 10**7, file_size, file_lines, line_min, line_cur, line_max
    integer(8) :: data_size_per_line = 8*3, access_count = 0
    ! data_per_line = 8*3 because 1 integer and 1 real(8) and 1 additional info
    ! Open file
    open (unit=funit, file=fname, status='old', action='read', iostat=ios)
    ! Get the file size
    inquire (funit, size=file_size)
    print *, "File size: ", file_size
    ! Calculate file lines
    file_lines = file_size/data_size_per_line
    print *, "File lines: ", file_lines
    ! Calculate line_cur
    line_min = 0
    line_max = file_lines
    seek = 0
    close (funit)
    ! Start timer
    call cpu_time(start_time)
    open (funit, file=fname, status='old', form='unformatted', iostat=ios)
    do
        ! file binary search using fseek and line_cur
        line_cur = line_min + (line_max - line_min)/2
        seek = line_cur*data_size_per_line
        call fseek(funit, seek, 0)
        read (funit, iostat=ios) idx, x
        access_count = access_count + 1
        if (ios /= 0) then
            print *, "End of file, ios = ", ios
            call ftell(funit, seek)
            exit
        end if
        print *, idx
        print *, "line_min: ", line_min
        print *, "line_cur: ", line_cur
        print *, "line_max: ", line_max
        if (idx < search) then
            line_min = line_cur
        else if (idx > search) then
            line_max = line_cur
        else
            print *, "Found: ", idx
            print *, "Value: ", x
            print *, "Access count: ", access_count
            exit
        end if

        ! Not found
        if (line_max <= line_min) then
            print *, "Not found ", search, " in file"
            exit
        end if
        print *, "Seek: ", seek
    end do
    close (1)
    call cpu_time(end_time)
    ! Print time
    print *, "[binary search] Time taken: ", end_time - start_time, " seconds"
    rewind (funit)
    call cpu_time(start_time)
    access_count = 0
    ! sequential search
    do
        read (funit, iostat=ios) idx, x
        access_count = access_count + 1
        if (ios /= 0) then
            print *, "End of file, ios = ", ios
            exit
        end if
        if (idx == search) then
            print *, "Found ", idx
            print *, "Value: ", x
            print *, "Access count: ", access_count
            exit
        end if
    end do
    call cpu_time(end_time)
    ! Print time
    print *, "[sequential search] Time taken: ", end_time - start_time, " seconds"
end program readfileperf
