#!/usr/bin/env bash

# One reason that not all tests are run in one calling of sbt
# is that we get out of memory errors when doing that.

# uncomment the lines below if processorAnnotator.type = "server"
# start up the Processors Server for tests to run against:
#echo 'Starting Processor Server...'
#sbt 'run-main org.clulab.processors.server.ProcessorServer' &
#sleep 20

overallExitCode=0

function runTest {
    echo "Testing '$1' suite..."
    sbt $1
    if [ $? -ne 0 ]; then
        echo "The '$1' suite failed!"
        overallExitCode=1
    fi
}

runTest "test"
runTest "processors/test"
runTest "main/test"
runTest "causalAssembly/test"
runTest "export/test"

#echo 'Stopping Processor Server...'
#sbt 'run-main org.clulab.processors.csshare.ShutdownProcessorServer'

if [ $overallExitCode -ne 0 ]; then
	echo "At least one test suite failed!"
	exit 1
fi
