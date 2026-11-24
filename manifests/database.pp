###############################################################################
# Shift tool database
###############################################################################

class shiftadmin::database inherits shiftadmin::params {

    $db_pkgs= [
        "mysql-server",
        "mysql-client",
        "python3-mysqldb",
        "python3-mysql.connector",
    ]
    package { $db_pkgs :
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

