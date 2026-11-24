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
}

