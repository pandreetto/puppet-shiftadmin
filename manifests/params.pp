###############################################################################
# Shift tool parameters
###############################################################################

class shiftadmin::params {

    if $networking["fqdn"] == "shift-belle2-test.pd.infn.it" {
        $server_name = "shift-belle2-test.pd.infn.it"
        $cert_file = "/etc/ssl/certs/shift-belle2-test.pd.infn.it-cert.pem"
        $key_file = "/etc/ssl/private/shift-belle2-test.pd.infn.it-key.pem"

        $oidc_issuer = "https://keycloak.desy.de/auth/realms/testing"
        $oidc_clientid = "b2_shift_tst"
        $oidc_secret = "CHANGEME"
        $oidc_passphrase = "CHANGEME"
    }
}

