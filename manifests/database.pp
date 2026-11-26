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

    file { "/etc/shiftadmin/dbaccount.ini":
        ensure   => file,
        owner    => "root",
        group    => "root",
        mode     => "0640",
        content  => epp("shiftadmin/dbaccount.ini.epp", {
            username => "$db_username",
            passwd   => "$db_pwd",
        }),
        tag      => [ "db_conffiles" ],
    }

    service { "mysql":
        ensure      => running,
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
    }

    Package <| tag == 'db-packages' |> -> File <| tag == 'db-db_conffiles' |>
    File <| tag == 'db-db_conffiles' |> ~> Service[ 'mysql' ]
}

