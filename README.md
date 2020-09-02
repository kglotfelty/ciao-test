# SDS CIAO testing harness scripts

This repro contains a copy of the scripts used to run the CIAO 
regression tests.

The tests themselves, together with their data files will be in a separate
repository (local due to size, ~80Gb).


## Setup

There are `bash` and `tcsh` setup scripts in the root directory to 
setup all the necessary environment variables.  The expectation is 
that users only need to modify the `ROOT` variable for their local
repro. 

```bash
tcsh% source setup.csh
  or
bash$ source setup.sh
```

## Example session

Here is an example of how to run the standard suite of regression tests

First be sure to setup for CIAO and MARX

```bash
source /exort/ciaox/bin/ciao.csh
source /exort/ciaox/marx-*/setup_marx.csh
```

and then run the tests

```bash
source setup.csh
cd $CIAOTEST_RESULTS
parallel_run_and_compare ciao_linux64_baseline_repro ciaox_20200828_Linux &
serve_results ciao_linux64_baseline_repro-ciaox_20200828_Linux &
gio open http://localhost:8080
```

## Summary of tasks

This is a summary of the high level tasks.

### `parallel_run_and_compare`

Usage: 

```bash
parallel_run_and_compare baselineset testset [-u] [tests]
```

Used to run and compare a new regression test set to the baseline test
set.

The `-u` flag tells the script to update the existing test database
otherwise a new database is created.

The baseline can be set to `none` to skip comparison.

Individual tools and individual tests can be run as the other test tools.

Calls:

- `list_tests`
- `run_tests`
- `compare_results`

The `serve_results` script can be used to monitor the progress
of the test.



### `serve_results`

Usage: 

```bash
serve_results baselineset-testset [port]
```

This application creates a small web server that can be used to monitor
the regression tests run by the `parallel_run_and_compare` test.

This script should be started in a separate window using the same
setup at parallel_run_and_compare.  Once the script is started,
you should pointer your web browser to the URL provided, usually

http://localhost:8080/


Calls:

- none

### `run_tests`

Usage 

```bash
run_tests outdir [tests]
```

Used to run the test scripts (ie the `*.MAIN` files).  Data are not
compared|checked.

Calls:

- none



### `run_and_compare`

Usage: 

```bash
run_and_compare baselineset testset [tests]
```

Used to run and compare a new regression test set to the baseline test
set.

Calls:

- `smart_compare`: on baseline and test sets
- `compare_results`: on the `compare.dat` file written out to `compare.log`



### `smart_compare`

Usage: 

```bash
smart_compare baselineset testset [tests]
```

Takes `smart_diff` output and creates an exit status log for each test.

- creates `smart_compare` directory
- creates `compare.dat`

Calls:

- `smart_diff`


### `compare_results`

Usage

```bash
compare_results -d compare.dat
```

creates `compare.log` file with pass/fail/summary info


### `smart_diff`

Usage:

```bash
smart_diff [-d] [-i] [-l log] /path1/tool/test/file /path2/tool/test/file
```

The big comparison script.  Edits can be made here to the diff
process.


## Specifying individual tests

Users can specify individual tests in the following ways:

```bash
run_tests outdir dmlist
```

will run all the `dmlist` tests.


```bash
run_tests outdir dmlist 01
```

will run the single `dmlist` `01.MAIN` test.

```bash
run_tests outdir "file(/path/to/my.lis)"
```

Individual tests can be specified in a list file.  Each line is a 
different test and should contain the tool name and test-id separated 
by white space.  You need to use the full path name to the list file.



## Authors

Most of these script were written by N. Durham, E. Galle, and C. Stawarz.
They (unfortunately) are mostly `ksh` scripts.  Minor tweaks have been
made by N. Lee and K. Glotfelty.
