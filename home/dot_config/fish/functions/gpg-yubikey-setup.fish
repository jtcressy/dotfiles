function gpg-yubikey-setup --description "Idempotently import GPG key stubs from a connected YubiKey"
    # Check if a YubiKey is connected
    set -l card_status (gpg --card-status 2>&1)
    or begin
        echo "No YubiKey detected. Plug in your YubiKey and try again."
        return 1
    end

    # Extract the public key URL and signature fingerprint from card status
    set -l pubkey_url (printf '%s\n' $card_status | string match -r 'URL of public key\s*:\s*(\S+)' | tail -1)
    set -l sig_fpr (printf '%s\n' $card_status | string match -r 'Signature key.*:\s*([\dA-F ]+)' | tail -1 | string replace -a ' ' '')

    if test -z "$sig_fpr"
        echo "Could not determine key fingerprint from card."
        return 1
    end

    # Check if the key is already known to GPG
    if gpg -k "$sig_fpr" &>/dev/null
        echo "GPG key stubs already present for $sig_fpr."
    else
        echo "Importing public key from YubiKey..."
        if test -n "$pubkey_url"
            echo "Fetching public key from: $pubkey_url"
            curl -sL "$pubkey_url" | gpg --import
        else
            echo "No public key URL on card. Attempting fetch via card-edit..."
            echo fetch | gpg --card-edit --command-fd 0
        end

        # Link stubs to the card
        gpg --card-status >/dev/null 2>&1

        if not gpg -k "$sig_fpr" &>/dev/null
            echo "Failed to import key stubs."
            return 1
        end
        echo "Key stubs imported successfully."
    end

    # Set ultimate trust if not already trusted
    # Trust field is the 2nd colon-separated field: u=ultimate, f=full, -=unknown, etc.
    set -l trust_field (gpg --with-colons --list-keys "$sig_fpr" 2>/dev/null | string match -r '^pub:(.):' | tail -1)
    if test "$trust_field" != u
        echo "Setting ultimate trust on key..."
        set -l primary_fpr (gpg --with-colons --list-keys "$sig_fpr" 2>/dev/null | string match -r '^fpr:::::::::([A-F0-9]+):' | tail -1)
        if test -n "$primary_fpr"
            echo "$primary_fpr:6:" | gpg --import-ownertrust
            echo "Trust set to ultimate."
        end
    else
        echo "Key already has ultimate trust."
    end

    echo "Done. GPG YubiKey setup is ready."
end
