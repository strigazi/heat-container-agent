#!/bin/bash

# Source in the options for the service
source /etc/sysconfig/service_options_file

# Run the service with sourced options
exec /path/to/service $OPTIONS