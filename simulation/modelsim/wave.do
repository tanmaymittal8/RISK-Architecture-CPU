onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/Clk
add wave -noupdate /testbench/Reset
add wave -noupdate /testbench/Execute
add wave -noupdate -radix decimal /testbench/SW
add wave -noupdate -radix decimal /testbench/AhexL
add wave -noupdate -radix decimal /testbench/AhexU
add wave -noupdate -radix decimal /testbench/BhexL
add wave -noupdate /testbench/BhexU
add wave -noupdate -radix hexadecimal /testbench/Aval
add wave -noupdate -radix binary /testbench/Bval
add wave -noupdate -radix decimal /testbench/Xval
add wave -noupdate -radix binary /testbench/XAB
add wave -noupdate /testbench/mult0/control_unit/curr_state
add wave -noupdate /testbench/mult0/control_unit/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22048 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {241680 ps}
