# NewSOC

#![OpenTitan logo]()

## About the project


## About this repository


## Documentation

### SDK User Guide
1. 修改soc及核相关头文件

```sh
./configure --host=riscv64-unknown-elf --with-machine-header=/mnt/e/Work/Gitee/freedom-e-sdk/bsp/sifive-hifive-unleashed/metal.h --with-machine-inline=/mnt/e/Work/Gitee/freedom-e-sdk/bsp/sifive-hifive-unleashed/metal-inline.h --with-platform-header=/mnt/e/Work/Gitee/freedom-e-sdk/bsp/sifive-hifive-unleashed/metal-platform.h
```

### User Guide

在根目录下查询帮助文档

```sh
make help
```

#### OPEN VERDI LIB

```sh
make g b vlib uvm_test=tlul_base_test ip_name=u500_top

```

#### IT CASE

gen, cmp, run case
```sh
make g b s uvm_test=tlul_base_test ip_name=u500_top

```

open fsdb

```sh
make fsdb uvm_test=tlul_base_test ip_name=u500_top

```


#### ST CASE

1. modify case like trunk/sw/case/test_demo.c

![st case demo](https://.png)

2. compile testcase

```sh
cd trunk/sw/case
make all TEST=case_demo

```

2. run simulation

```sh
make g b s uvm_test=soft_base_test ip_name=u500_top

```



## Licensing

Unless otherwise noted, everything in this repository is covered by the Apache
License, Version 2.0 (see [LICENSE](./LICENSE) for full text).

## Dependancy

pip3 install --upgrade pip
pip3 install fusesoc hjson mistletoe premailer tabulate mako
pip3 install -r python-requirements.txt
pip3 install git+https://github.com/lowRISC/fusesoc.git#1.12.0


