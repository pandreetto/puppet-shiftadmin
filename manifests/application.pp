###############################################################################
# Shift tool django application
###############################################################################

class shiftadmin::application inherits shiftadmin::params {

    package { "python3-django":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-django-auth-ldap":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-django-filters":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-whitenoise":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-pycountry":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-icalendar":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-geopy":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-jinja2":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-holidays":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-gspread":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

    package { "python3-pip":
        ensure  => installed,
        tag     => [ "app-packages" ],
    }

}

