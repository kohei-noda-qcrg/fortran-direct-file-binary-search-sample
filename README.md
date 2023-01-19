# Fortran-direct-file-binary-search-sample

This is a sample of Fortran code that does a direct binary search without reading all the lines of a sorted binary file.

## Download

```sh
git clone https://github.com/kohei-noda-qcrg/fortran-direct-file-binary-search-sample.git
```

## Build

```sh
cd fortran-direct-file-binary-search-sample
# Use $FC environment variable if it is set, otherwise use gfortran to compile the code
make
# or if you want to set the compiler explicitly, use the following command
FC=ifort make
```

## Usage

### Generate a binary file

```sh
./create-file
```

### Compare a direct binary search with a sequential search

```sh
./read-file-performance
```

- Output of the above command is as follows

    ```txt
    File size:             240000000
    File lines:              10000000
                5000001
    line_min:                     0
    line_cur:                     0
    line_max:              10000000
    Seek:             120000000
                2500001
    line_min:                     0
    line_cur:                     0
    line_max:               5000000
    Seek:              60000000
                1250001
        .
        .
        .
    line_min:                999992
    line_cur:                999992
    line_max:               1000002
    Seek:              23999928
                1000000
    line_min:                999997
    line_cur:                999997
    line_max:               1000002
    Found:               1000000
    Value:    1000000.0000000000
    Access count:                    22
    [binary search] Time taken:    2.5700000000000007E-004  seconds
    Found               1000000
    Value:    1000000.0000000000
    Access count:               1000000
    [sequential search] Time taken:   0.10264200000000000       seconds
    ```
