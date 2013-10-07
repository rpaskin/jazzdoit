#!/bin/bash
PATH=$PATH:/home/ubuntu/.rvm/bin
source "/home/ubuntu/.rvm/scripts/rvm"
# source ".rvmrc"  # loading local rvmrc if necessary
# or thin or unicorn start at this point, do NOT start as daemon, upstart handles daemonizing for you
unicorn_rails -E production -c ./config/unicorn.rb
