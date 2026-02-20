#!/bin/bash
#mainframe_operations.sh
export PATH=$PATH:/usr/lpp/java/J8.0_64/bin
export JAVA_HOME=/usr/lpp/java/J8.0_64
export PATH=$PATH:/usr/lpp/zowe/cli/node/bin
java --version
ZOWE_USERNAME="Z79770"
cd cobolcheck
echo "Changed to $(pwd)"
ls -al
chmod +x cobolcheck
echo "Made linux_gnucobol_run_tests executable"
cd..
run_cobolcheck() {
  program=$1
    echo "Running cobolcheck for $program"
    ./cobolcheck -p $program
    echo "Execution completed for $program"
    if [ -f "CC##99.CBL" ]; then
      if cp CC##99.CBL "//'${ZOWE_USERNAME}.CBL($program)'"; then
        echo "Copied CC##99.CBL to ${ZOWE_USERNAME}.CBL($program)"
      else
        echo "Failed copy to ${ZOWE_USERNAME}".CBL($program)"
      fi
    else
      echo "CC##99.CBL not found for $program"
    fi
    if [ -f "${program}.JCL" ]; then
      if cp ${program}.JCL "//'${ZOWE_USERNAME.JCL($program)'"; then
        echo "Copied ${program}.JCL to ${ZOWE_USERNAME}.JCL($program)"
      else
        echo "Failed"
      fi
    else
      echo "${program}.JCL not found!"
    fi
 }
 for program in NUMBERS EMPRAY DEPTRAY; do
   run_cobolcheck $program
 done
 echo "Mainframe operations completed!"
