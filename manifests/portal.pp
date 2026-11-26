###############################################################################
# Shift tool web interface
###############################################################################

class shiftadmin::portal inherits shiftadmin::params {

    $web_pkgs = [
        "apache2",
        "libapache2-mod-wsgi-py3",
        "libapache2-mod-auth-openidc",
    ]
    package { $web_pkgs :
        ensure  => installed,
        tag     => [ "portal-packages" ],
    }

    service { "apache2":
        ensure      => running,
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
    }

    file { "/etc/apache2/ssl-certs":
        ensure   => directory,
        owner   => "root",
        group    => "root",
        mode     => "0755",
    }
    
    file { "/etc/apache2/ssl-certs/ca-bundle.pem":
        ensure   => file,
        owner    => "root",
        group    => "root",
        mode     => "0644",
        content  => file("shiftadmin/ca-bundle.pem"),
        require  => File[ "/etc/apache2/ssl-certs" ],
        tag      => [ "portal_conffiles" ],
    }

    file { "/etc/apache2/sites-available/django.conf":
        ensure   => file,
        owner    => "root",
        group    => "root",
        mode     => "0644",
        content  => epp("shiftadmin/django.conf.epp", {
            cert_file   => "$cert_file",
            key_file    => "$key_file",
            server_name => "$server_name",
        }),
        tag      => [ "portal_conffiles" ],
    }

    file { "/etc/apache2/conf-available/auth_openidc.conf":
        ensure   => file,
        owner    => "root",
        group    => "root",
        mode     => "0644",
        content  => epp("shiftadmin/auth_openidc.conf.epp", {
            server_name     => "$server_name",
            oidc_issuer     => "$oidc_issuer",
            oidc_clientid   => "$oidc_clientid",
            oidc_secret     => "$oidc_secret",
            oidc_passphrase => "$oidc_passphrase",
        }),
        tag      => [ "portal_conffiles" ],
    }

    # Workaround for hard-coded paths
    file { "/var/www/html/connections":
        ensure  => directory,
        owner   => "root",
        group   => "root",
        mode    => "0755",
        require => Package <| tag == 'portal-packages' |>
    }

    file { "/var/www/html/connections/python":
        ensure  => directory,
        owner   => "root",
        group   => "root",
        mode    => "0755",
        require => File[ "/var/www/html/connections" ]
    }
    
    file { "/var/www/html/connections/python/appreader.ini":
        ensure  => link,
        target  => "/etc/shiftadmin/dbaccount.ini",
        require => File[ "/var/www/html/connections/python" ],
    }
    
    file { "/var/www/html/connections/python/appwriter.ini":
        ensure  => link,
        target  => "/etc/shiftadmin/dbaccount.ini",
        require => File[ "/var/www/html/connections/python" ],
    }
    
    # Enable sites and modules (see a2ensite a2enmod)
    file { "/etc/apache2/sites-enabled/django.conf":
        ensure  => link,
        target  => "/etc/apache2/sites-available/django.conf",
        require => File[ "/etc/apache2/sites-available/django.conf" ],
    }

    file { "/etc/apache2/mods-enabled/ssl.conf":
        ensure  => link,
        target  => "/etc/apache2/mods-available/ssl.conf",
        require => Package[ "apache2" ],
    }

    file { "/etc/apache2/mods-enabled/ssl.load":
        ensure  => link,
        target  => "/etc/apache2/mods-available/ssl.load",
        require => Package[ "apache2" ],
    }

    file { "/etc/apache2/conf-enabled/auth_openidc.conf":
        ensure  => link,
        target  => "/etc/apache2/conf-available/auth_openidc.conf",
        require => File[ "/etc/apache2/conf-available/auth_openidc.conf" ],
    }

    Package <| tag == 'portal-packages' |> ->  File <| tag == 'portal_conffiles' |>
    File <| tag == 'portal_conffiles' |> ~> Service[ 'apache2' ]
}

