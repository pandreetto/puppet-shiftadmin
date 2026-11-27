###############################################################################
# Shift tool django application
###############################################################################

class shiftadmin::application inherits shiftadmin::params {

    $app_pkgs = [
        "python3-django",
        "python3-django-auth-ldap",
        "python3-django-filters",
        "python3-whitenoise",
        "python3-pycountry",
        "python3-icalendar",
        "python3-geopy",
        "python3-jinja2",
        "python3-holidays",
        "python3-gspread",
        "python3-pip"
    ]

    package { $app_pkgs :
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    exec { "install_summernote":
        command => "pip install --break-system-packages django-summernote",
        require => Package[ "python3-pip" ],
    }

    file { '/usr/local/web_shift_tool':
        ensure => link,
        target => "/var/www/shiftadmin/new-wshft/",
    }

    file { "/etc/shiftadmin/conf.d":
        ensure  => directory,
        owner   => "root",
        group   => "root",
        mode    => "0755",
    }

    file { "/etc/shiftadmin/conf.d/20_database.conf":
        ensure   => file,
        owner    => "root",
        group    => "root",
        mode     => "0644",
        tag      => [ "webapp-conffiles" ],
        require  => File[ '/etc/shiftadmin/conf.d' ]
        content  => epp("shiftadmin/web_shift_tool_db.conf.epp", {
            username => "$db_username",
            passwd   => "$db_pwd",
        }),
    }

    if $use_ldap {
        file { "/etc/shiftadmin/conf.d/30_ldap.conf":
            ensure   => file,
            owner    => "root",
            group    => "root",
            mode     => "0644",
            tag      => [ "webapp-conffiles" ],
            require  => File[ '/etc/shiftadmin/conf.d' ]
            content  => epp("shiftadmin/web_shift_tool_ldap.conf.epp", {
                ldap_server_uri => "$ldap_server_uri",
            }),
        }
    }

    file { "/etc/shiftadmin/conf.d/40_core.conf":
        ensure   => file,
        owner    => "root",
        group    => "root",
        mode     => "0644",
        tag      => [ "webapp-conffiles" ],
        require  => File[ '/etc/shiftadmin/conf.d' ]
        content  => epp("shiftadmin/web_shift_tool_core.conf.epp", {
            django_secret_key => "$django_secret_key",
            django_debug      => "$django_debug",
            allowed_hosts     => "$allowed_hosts",
        }),
    }

}

