###############################################################################
# Shift tool configuration
###############################################################################

class shiftadmin {

    class { 'shiftadmin::database': }
    class { 'shiftadmin::application': }
    class { 'shiftadmin::portal': }

    Class[ 'shiftadmin::database' ] -> Class[ 'shiftadmin::application' ]
    Class[ 'shiftadmin::application' ] -> Class[ 'shiftadmin::portal' ]
}
