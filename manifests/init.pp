###############################################################################
# Shift tool configuration
###############################################################################

class shiftadmin {

    class { 'shiftadmin::database': }
    class { 'shiftadmin::application': }
    class { 'shiftadmin::portal': }

    file { "/etc/shiftadmin":
        ensure => directory,
        owner  => "root",
        group  => "root",
        mode   => "0755",
        tag    => [ "sh-preset" ],
    }

    File <| tag == 'sh-preset' |> -> Class[ 'shiftadmin::database' ]
    Class[ 'shiftadmin::database' ] -> Class[ 'shiftadmin::application' ]
    Class[ 'shiftadmin::application' ] -> Class[ 'shiftadmin::portal' ]
}
