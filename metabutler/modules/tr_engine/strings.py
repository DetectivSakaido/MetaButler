import yaml
from codecs import encode, decode

from metabutler import LOGGER
from metabutler.modules.sql.locales_sql import prev_locale

LANGUAGES = ['en-US']

strings = {}

for i in LANGUAGES:
    strings[i] = yaml.full_load(open("locales/" + i + ".yml", "r"))


def tld(chat_id, t, show_none=True):
    LANGUAGE = prev_locale(chat_id)

    if LANGUAGE:
        LOCALE = LANGUAGE.locale_name
        if LOCALE in ('en-US') and t in strings['en-US']:
            result = decode(
                encode(strings['en-US'][t], 'latin-1', 'backslashreplace'),
                'unicode-escape')
            return result

    if t in strings['en-US']:
        result = decode(
            encode(strings['en-US'][t], 'latin-1', 'backslashreplace'),
            'unicode-escape')
        return result

    err = f"No string found for {t}."
    LOGGER.warning(err)
    return err


def tld_list(chat_id, t):
    LANGUAGE = prev_locale(chat_id)

    if LANGUAGE:
        LOCALE = LANGUAGE.locale_name
        if LOCALE in ('en-US') and t in strings['en-US']:
            return strings['en-US'][t]

    if t in strings['en-US']:
        return strings['en-US'][t]

    LOGGER.warning(f"#NOSTR No string found for {t}.")
    return f"No string found for {t}."
