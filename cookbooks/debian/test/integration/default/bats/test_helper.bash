# Print Debian codename
codename() {
    if command -v lsb_release >/dev/null; then
        lsb_release -s -c
    else
        case "$(< /etc/debian_version)" in
            6.*) echo 'squeeze';;
            7.*) echo 'wheezy';;
            *)   echo '???';;
        esac
    fi
}

# Escape to be used in a regexp pattern
regexp_escape() {
    printf '%s' "$1" | sed -e 's/[]()$*.^|[]/\\&/g'
}
