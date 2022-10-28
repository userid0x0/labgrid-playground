#!/bin/bash
. $(dirname ${0})/../osht.sh

function main() {
  cat << EOF > $(dirname ${0})/config-place.yaml
# as simple as possible
targets:
  main:
    resources:
      RemotePlace:
        name: regress
    drivers:
    - SiSPMPowerDriver:
        bindings:
          port: "dut"
EOF

  labgrid-client -c $(dirname ${0})/config-place.yaml unlock --kick >/dev/null 2>&1
  labgrid-client -p regress unlock --kick >/dev/null 2>&1
  labgrid-client -c $(dirname ${0})/config-place.yaml delete >/dev/null 2>&1
  labgrid-client -p regress delete >/dev/null 2>&1

  echo "..."
  cat $(dirname ${0})/config-place.yaml
  regress
}

function regress() {
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml create
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml add-match ame-odroidc4/ultra96-example/NetworkSerialPort
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml add-match ame-odroidc4/ultra96-example/NetworkUSBSDMuxDevice
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1 dut
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml lock
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get -n dut
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off -n dut
  NRUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get -n SiSPM-Port1
  NRUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off -n SiSPM-Port1
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml release

  # interesting case - wrong binding, thus this Place shouldn't work
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml del-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1 main
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml lock
  NRUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get
  NRUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off
  NRUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get -n main
  NRUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off -n main
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml release

  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml del-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port1 main#dut
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml add-named-match ame-odroidc4/ultra96-example/NetworkSiSPMPowerPort/SiSPM-Port2 tools
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml lock
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off
  NRUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get -n SiSPM-Port1
  NRUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off -n SiSPM-Port1
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get -n main#dut
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off -n main#dut
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get -n dut
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off -n dut
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power get -n tools
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml power off -n tools
  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml release

  RUNS labgrid-client -c $(dirname ${0})/config-place.yaml delete
}

main