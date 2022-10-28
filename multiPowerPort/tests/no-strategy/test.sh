#!/bin/bash
. $(dirname ${0})/../osht.sh

NRUNS labgrid-client -p regress unlock --kick
RUNS labgrid-client -p regress delete && true
RUNS labgrid-client -p regress create
RUNS labgrid-client -p regress add-match ame-odroidc4/ultra96-example/NetworkSerialPort
RUNS labgrid-client -p regress add-match ame-odroidc4/ultra96-example/NetworkUSBSDMuxDevice
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1 SiSPM-Port1
RUNS labgrid-client -p regress lock
RUNS labgrid-client -p regress power get
RUNS labgrid-client -p regress power off
RUNS labgrid-client -p regress power get -n SiSPM-Port1
RUNS labgrid-client -p regress power off -n SiSPM-Port1
NRUNS labgrid-client -p regress power get -n SiSPM-Port2
NRUNS labgrid-client -p regress power off -n SiSPM-Port2
RUNS labgrid-client -p regress release

RUNS labgrid-client -p regress del-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1 main#dut
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port2 tools
RUNS labgrid-client -p regress lock
RUNS labgrid-client -p regress power get
RUNS labgrid-client -p regress power off
NRUNS labgrid-client -p regress power get -n SiSPM-Port1
NRUNS labgrid-client -p regress power off -n SiSPM-Port1
RUNS labgrid-client -p regress power get -n main#dut
RUNS labgrid-client -p regress power off -n main#dut
RUNS labgrid-client -p regress power get -n dut
RUNS labgrid-client -p regress power off -n dut
RUNS labgrid-client -p regress power get -n tools
RUNS labgrid-client -p regress power off -n tools
RUNS labgrid-client -p regress release

RUNS labgrid-client -p regress del-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1
RUNS labgrid-client -p regress del-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port2
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1 main#dut
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port2 main#tools
RUNS labgrid-client -p regress lock
NRUNS labgrid-client -p regress power get
NRUNS labgrid-client -p regress power off
RUNS labgrid-client -p regress release

RUNS labgrid-client -p regress del-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1
RUNS labgrid-client -p regress del-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port2
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1 main#dut
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port2 tools
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkUSBPowerPort/USBPowerPort USBPowerPort
RUNS labgrid-client -p regress lock
RUNS labgrid-client -p regress power get
RUNS labgrid-client -p regress power off
# uhubctl isn't installed - check for ssh error message - unknown command
NRUNS labgrid-client -p regress power get -n USBPowerPort
GREP non-zero
RUNS labgrid-client -p regress release

RUNS labgrid-client -p regress del-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1
RUNS labgrid-client -p regress del-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port2
RUNS labgrid-client -p regress del-match ame-odroidc4/ultra96-example/NetworkUSBPowerPort/USBPowerPort
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1 main#dut
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port2 tools
RUNS labgrid-client -p regress add-named-match ame-odroidc4/ultra96-example/NetworkUSBPowerPort/USBPowerPort main#USBPowerPort
RUNS labgrid-client -p regress lock
NRUNS labgrid-client -p regress power get
NRUNS labgrid-client -p regress power off
RUNS labgrid-client -p regress release

RUNS labgrid-client -p regress delete