###############################################################################
# Shift tool web interface
###############################################################################

class shiftadmin::portal inherits shiftadmin::params {

    package { "apache2":
        ensure  => installed,
        tag     => [ "portal-packages" ],
    }

    package { "libapache2-mod-wsgi-py3":
        ensure  => installed,
        tag     => [ "portal-packages" ],
    }

    package { "libapache2-mod-auth-openidc":
        ensure  => installed,
        tag     => [ "portal-packages" ],
    }

    service { "apache2":
        ensure      => running,
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
    }

    Package <| tag == 'portal-packages' |> ~> Service[ 'apache2' ]
}

