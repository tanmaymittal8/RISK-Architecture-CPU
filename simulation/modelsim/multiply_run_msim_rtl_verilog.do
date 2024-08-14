transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Mechi/Desktop/ece\ 385\ uiuc/lab4 {C:/Users/Mechi/Desktop/ece 385 uiuc/lab4/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/Mechi/Desktop/ece\ 385\ uiuc/lab4 {C:/Users/Mechi/Desktop/ece 385 uiuc/lab4/full_adder.sv}
vlog -sv -work work +incdir+C:/Users/Mechi/Desktop/ece\ 385\ uiuc/lab4 {C:/Users/Mechi/Desktop/ece 385 uiuc/lab4/control.sv}
vlog -sv -work work +incdir+C:/Users/Mechi/Desktop/ece\ 385\ uiuc/lab4 {C:/Users/Mechi/Desktop/ece 385 uiuc/lab4/addition_unit.sv}
vlog -sv -work work +incdir+C:/Users/Mechi/Desktop/ece\ 385\ uiuc/lab4 {C:/Users/Mechi/Desktop/ece 385 uiuc/lab4/multiply.sv}
vlog -sv -work work +incdir+C:/Users/Mechi/Desktop/ece\ 385\ uiuc/lab4 {C:/Users/Mechi/Desktop/ece 385 uiuc/lab4/reg_8.sv}

vlog -sv -work work +incdir+C:/Users/Mechi/Desktop/ece\ 385\ uiuc/lab4 {C:/Users/Mechi/Desktop/ece 385 uiuc/lab4/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
