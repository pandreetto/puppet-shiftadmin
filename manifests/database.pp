###############################################################################
# Shift tool database
###############################################################################

class shiftadmin::database inherits shiftadmin::params {

    package { "mysql-server":
        ensure  => installed,
        tag     => [ "db-packages" ],
    }

    package { "mysql-client":
        ensure  => installed,
        tag     => [ "db-packages" ],
    }

    package { "python3-mysqldb":
        ensure  => installed,
        tag     => [ "db-packages" ],
    }

    package { "python3-mysql.connector":
        ensure  => installed,
        tag     => [ "db-packages" ],
    }

    service { "mysql":
        ensure      => running,
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
    }

    Package <| tag == 'db-packages' |> ~> Service[ 'mysql' ]
}

