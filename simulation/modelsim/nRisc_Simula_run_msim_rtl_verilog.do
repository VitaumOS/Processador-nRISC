transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/Banco_Registradores.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/Memoria_Dados.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/PC.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/Memoria_Instrucao.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/Registrador_COND.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/ULA.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/MUX.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/Extensor_Sinal_3b8.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/Extensor_Sinal_5b8.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/Somador.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/Porta_AND.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/nRisc.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/unidade_controle.v}
vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/ula_controle.v}

vlog -vlog01compat -work work +incdir+C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC\ I/Aula\ 13/nRISC/Processador-nRISC {C:/Users/vitor/Documents/CEFET/Periodo_3/LAOC I/Aula 13/nRISC/Processador-nRISC/nRisc_Simula.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  nRisc_Simula

add wave *
view structure
view signals
run -all
