import html
import wikipedia
import re, os
from datetime import datetime
from typing import Optional, List

import requests
from telegram import Message, Chat, Update, Bot, MessageEntity
from telegram import ParseMode, ReplyKeyboardRemove, InlineKeyboardMarkup, InlineKeyboardButton
from telegram.ext import CommandHandler, run_async, Filters
from telegram.utils.helpers import escape_markdown, mention_html
from telegram.error import BadRequest

from metabutler import dispatcher, OWNER_ID, SUDO_USERS, WHITELIST_USERS, INFOPIC, TOKEN
from metabutler.__main__ import STATS, USER_INFO
from metabutler.modules.disable import DisableAbleCommandHandler
from metabutler.modules.helper_funcs.extraction import extract_user

from metabutler.modules.tr_engine.strings import tld
import metabutler.modules.sql.users_sql as sql

from requests import get

@run_async
def gifid(bot:Bot, update: Update):
    msg = update.effective_message
    if msg.reply_to_message and msg.reply_to_message.animation:
        update.effective_message.reply_text(
            f"Gif ID:\n<code>{msg.reply_to_message.animation.file_id}</code>",
            parse_mode=ParseMode.HTML,
        )
    else:
        update.effective_message.reply_text("Please reply to a gif to get its ID.")

@run_async
def get_id(bot: Bot, update: Update, args: List[str]):
    user_id = extract_user(update.effective_message, args)
    chat = update.effective_chat  # type: Optional[Chat]
    if user_id:
        if update.effective_message.reply_to_message and update.effective_message.reply_to_message.forward_from:
            user1 = update.effective_message.reply_to_message.from_user
            user2 = update.effective_message.reply_to_message.forward_from
            update.effective_message.reply_markdown(
                tld(chat.id,
                    "misc_get_id_1").format(escape_markdown(user2.first_name),
                                            user2.id,
                                            escape_markdown(user1.first_name),
                                            user1.id))
        else:
            user = bot.get_chat(user_id)
            update.effective_message.reply_markdown(
                tld(chat.id,
                    "misc_get_id_2").format(escape_markdown(user.first_name),
                                            user.id))
    else:
        chat = update.effective_chat  # type: Optional[Chat]
        if chat.type == "private":
            update.effective_message.reply_markdown(
                tld(chat.id, "misc_id_1").format(chat.id))

        else:
            update.effective_message.reply_markdown(
                tld(chat.id, "misc_id_2").format(chat.id))

@run_async
def info(bot: Bot, update: Update, args: List[str]):
    message = update.effective_message
    chat = update.effective_chat
    user_id = extract_user(update.effective_message, args)

    if user_id:
        user = bot.get_chat(user_id)

    elif not message.reply_to_message and not args:
        user = message.from_user

    elif not message.reply_to_message and (
        not args
        or (
            len(args) >= 1
            and not args[0].startswith("@")
            and not args[0].isdigit()
            and not message.parse_entities([MessageEntity.TEXT_MENTION])
        )
    ):
        message.reply_text("I can't extract a user from this.")
        return

    else:
        return

    text = (
        f"<b>Characteristics:</b>\n"
        f"ID: <code>{user.id}</code>\n"
        f"First Name: {html.escape(user.first_name)}"
    )

    if user.last_name:
        text += f"\nLast Name: {html.escape(user.last_name)}"

    if user.username:
        text += f"\nUsername: @{html.escape(user.username)}"

    text += f"\nPermanent user link: {mention_html(user.id, 'link')}"

    num_chats = sql.get_user_num_chats(user.id)
    text += f"\nChat count: <code>{num_chats}</code>"

    try:
        user_member = chat.get_member(user.id)
        if user_member.status == "administrator":
            result = requests.post(
                f"https://api.telegram.org/bot{TOKEN}/getChatMember?chat_id={chat.id}&user_id={user.id}"
            )
            result = result.json()["result"]
            if "custom_title" in result.keys():
                custom_title = result["custom_title"]
                text += f"\nTitle: <b>{custom_title}</b>"
    except BadRequest:
        pass

    if user.id == OWNER_ID:
        text += tld(chat.id, "misc_info_is_original_owner")
    elif user.id in SUDO_USERS:
        text += tld(chat.id, "misc_info_is_sudo")
    elif user.id in WHITELIST_USERS:
        text += tld(chat.id, "misc_info_is_whitelisted")

    for mod in USER_INFO:
        if mod.__mod_name__ == "Users":
            continue

        try:
            mod_info = mod.__user_info__(user.id)
        except TypeError:
            mod_info = mod.__user_info__(user.id, chat.id)
        if mod_info:
            text += "\n" + mod_info
            
    if INFOPIC:
        try:
            profile = bot.get_user_profile_photos(user.id).photos[0][-1]
            _file = bot.get_file(profile["file_id"])
            _file.download(f"{user.id}.png")

            message.reply_photo(
                photo=open(f"{user.id}.png", "rb"),
                caption=(text),
                parse_mode=ParseMode.HTML,
            )

            os.remove(f"{user.id}.png")
        # Incase user don't have profile pic, send normal text
        except IndexError:
            message.reply_text(
                text, parse_mode=ParseMode.HTML, disable_web_page_preview=True
            )

    else:
        message.reply_text(
            text, parse_mode=ParseMode.HTML, disable_web_page_preview=True
        )

@run_async
def reply_keyboard_remove(bot: Bot, update: Update):
    reply_keyboard = []
    reply_keyboard.append([ReplyKeyboardRemove(remove_keyboard=True)])
    reply_markup = ReplyKeyboardRemove(remove_keyboard=True)
    old_message = bot.send_message(
        chat_id=update.message.chat_id,
        text='trying',  # This text will not get translated
        reply_markup=reply_markup,
        reply_to_message_id=update.message.message_id)
    bot.delete_message(chat_id=update.message.chat_id,
                       message_id=old_message.message_id)

@run_async
def markdown_help(bot: Bot, update: Update):
    chat = update.effective_chat  # type: Optional[Chat]
    update.effective_message.reply_text(tld(chat.id, "misc_md_list"),
                                        parse_mode=ParseMode.HTML)
    update.effective_message.reply_text(tld(chat.id, "misc_md_try"))
    update.effective_message.reply_text(tld(chat.id, "misc_md_help"))


@run_async
def stats(bot: Bot, update: Update):
    update.effective_message.reply_text(
        # This text doesn't get translated as it is internal message.
        "*Current Stats:*\n" + "\n".join([mod.__stats__() for mod in STATS]),
        parse_mode=ParseMode.MARKDOWN)


@run_async
def github(bot: Bot, update: Update):
    message = update.effective_message
    text = message.text[len('/git '):]
    usr = get(f'https://api.github.com/users/{text}').json()
    if usr.get('login'):
        text = f"*Username:* [{usr['login']}](https://github.com/{usr['login']})"

        whitelist = [
            'name', 'id', 'type', 'location', 'blog', 'bio', 'followers',
            'following', 'hireable', 'public_gists', 'public_repos', 'email',
            'company', 'updated_at', 'created_at'
        ]

        difnames = {
            'id': 'Account ID',
            'type': 'Account type',
            'created_at': 'Account created at',
            'updated_at': 'Last updated',
            'public_repos': 'Public Repos',
            'public_gists': 'Public Gists'
        }

        goaway = [None, 0, 'null', '']

        for x, y in usr.items():
            if x in whitelist:
                if x in difnames:
                    x = difnames[x]
                else:
                    x = x.title()

                if x == 'Account created at' or x == 'Last updated':
                    y = datetime.strptime(y, "%Y-%m-%dT%H:%M:%SZ")

                if y not in goaway:
                    if x == 'Blog':
                        x = "Website"
                        y = f"[Here!]({y})"
                        text += ("\n*{}:* {}".format(x, y))
                    else:
                        text += ("\n*{}:* `{}`".format(x, y))
        reply_text = text
    else:
        reply_text = "User not found. Make sure you entered valid username!"
    message.reply_text(reply_text,
                       parse_mode=ParseMode.MARKDOWN,
                       disable_web_page_preview=True)


@run_async
def repo(bot: Bot, update: Update, args: List[str]):
    message = update.effective_message
    text = message.text[len('/repo '):]
    usr = get(f'https://api.github.com/users/{text}/repos?per_page=40').json()
    reply_text = "*Repo*\n"
    for i in range(len(usr)):
        reply_text += f"[{usr[i]['name']}]({usr[i]['html_url']})\n"
    message.reply_text(reply_text,
                       parse_mode=ParseMode.MARKDOWN,
                       disable_web_page_preview=True)


@run_async
def paste(bot: Bot, update: Update, args: List[str]):
    chat = update.effective_chat  # type: Optional[Chat]
    BURL = 'https://del.dog'
    message = update.effective_message
    if message.reply_to_message:
        data = message.reply_to_message.text
    elif len(args) >= 1:
        data = message.text.split(None, 1)[1]
    else:
        message.reply_text(tld(chat.id, "misc_paste_invalid"))
        return

    r = requests.post(f'{BURL}/documents', data=data.encode('utf-8'))

    if r.status_code == 404:
        update.effective_message.reply_text(tld(chat.id, "misc_paste_404"))
        r.raise_for_status()

    res = r.json()

    if r.status_code != 200:
        update.effective_message.reply_text(res['message'])
        r.raise_for_status()

    key = res['key']
    if res['isUrl']:
        reply = tld(chat.id, "misc_paste_success").format(BURL, key, BURL, key)
    else:
        reply = f'{BURL}/{key}'
    update.effective_message.reply_text(reply,
                                        parse_mode=ParseMode.MARKDOWN,
                                        disable_web_page_preview=True)


@run_async
def get_paste_content(bot: Bot, update: Update, args: List[str]):
    BURL = 'https://del.dog'
    message = update.effective_message
    chat = update.effective_chat  # type: Optional[Chat]

    if len(args) >= 1:
        key = args[0]
    else:
        message.reply_text(tld(chat.id, "misc_get_pasted_invalid"))
        return

    format_normal = f'{BURL}/'
    format_view = f'{BURL}/v/'

    if key.startswith(format_view):
        key = key[len(format_view):]
    elif key.startswith(format_normal):
        key = key[len(format_normal):]

    r = requests.get(f'{BURL}/raw/{key}')

    if r.status_code != 200:
        try:
            res = r.json()
            update.effective_message.reply_text(res['message'])
        except Exception:
            if r.status_code == 404:
                update.effective_message.reply_text(
                    tld(chat.id, "misc_paste_404"))
            else:
                update.effective_message.reply_text(
                    tld(chat.id, "misc_get_pasted_unknown"))
        r.raise_for_status()

    update.effective_message.reply_text('```' + escape_markdown(r.text) +
                                        '```',
                                        parse_mode=ParseMode.MARKDOWN)


@run_async
def get_paste_stats(bot: Bot, update: Update, args: List[str]):
    BURL = 'https://del.dog'
    message = update.effective_message
    chat = update.effective_chat  # type: Optional[Chat]

    if len(args) >= 1:
        key = args[0]
    else:
        message.reply_text(tld(chat.id, "misc_get_pasted_invalid"))
        return

    format_normal = f'{BURL}/'
    format_view = f'{BURL}/v/'

    if key.startswith(format_view):
        key = key[len(format_view):]
    elif key.startswith(format_normal):
        key = key[len(format_normal):]

    r = requests.get(f'{BURL}/documents/{key}')

    if r.status_code != 200:
        try:
            res = r.json()
            update.effective_message.reply_text(res['message'])
        except Exception:
            if r.status_code == 404:
                update.effective_message.reply_text(
                    tld(chat.id, "misc_paste_404"))
            else:
                update.effective_message.reply_text(
                    tld(chat.id, "misc_get_pasted_unknown"))
        r.raise_for_status()

    document = r.json()['document']
    key = document['_id']
    views = document['viewCount']
    reply = f'Stats for **[/{key}]({BURL}/{key})**:\nViews: `{views}`'
    update.effective_message.reply_text(reply, parse_mode=ParseMode.MARKDOWN)


@run_async
def ud(bot: Bot, update: Update):
    message = update.effective_message
    text = message.text[len('/ud '):]
    if text == '':
        text = "Cockblocked By Steve Jobs"
    results = get(
        f'http://api.urbandictionary.com/v0/define?term={text}').json()
    try:
        reply_text = f'Word: {text}\nDefinition: {results["list"][0]["definition"]}'
    except:
        reply_text = "Oops can't find that."
    message.reply_text(reply_text)


@run_async
def wiki(bot: Bot, update: Update):
    kueri = re.split(pattern="wiki", string=update.effective_message.text)
    wikipedia.set_lang("en")
    if len(str(kueri[1])) == 0:
        update.effective_message.reply_text("Enter keywords!")
    else:
        try:
            pertama = update.effective_message.reply_text("🔄 Loading...")
            keyboard = InlineKeyboardMarkup([[
                InlineKeyboardButton(text="🔧 More Info...",
                                     url=wikipedia.page(kueri).url)
            ]])
            bot.editMessageText(chat_id=update.effective_chat.id,
                                message_id=pertama.message_id,
                                text=wikipedia.summary(kueri, sentences=10),
                                reply_markup=keyboard)
        except wikipedia.PageError as e:
            update.effective_message.reply_text("⚠ Error: {}".format(e))
        except BadRequest as et:
            update.effective_message.reply_text("⚠ Error: {}".format(et))
        except wikipedia.exceptions.DisambiguationError as eet:
            update.effective_message.reply_text(
                "⚠ Error\n There are too many query! Express it more!\nPossible query result:\n{}"
                .format(eet))


def format_integer(number, thousand_separator=','):
    def reverse(string):
        string = "".join(reversed(string))
        return string

    s = reverse(str(number))
    count = 0
    result = ''
    for char in s:
        count = count + 1
        if count % 3 == 0:
            if len(s) == count:
                result = char + result
            else:
                result = thousand_separator + char + result
        else:
            result = char + result
    return result


__help__ = True

ID_HANDLER = DisableAbleCommandHandler("id",
                                       get_id,
                                       pass_args=True,
                                       admin_ok=True)
INFO_HANDLER = DisableAbleCommandHandler("info",
                                         info,
                                         pass_args=True,
                                         admin_ok=True)
GITHUB_HANDLER = DisableAbleCommandHandler("git", github, admin_ok=True)
REPO_HANDLER = DisableAbleCommandHandler("repo",
                                         repo,
                                         pass_args=True,
                                         admin_ok=True)

MD_HELP_HANDLER = CommandHandler("markdownhelp",
                                 markdown_help,
                                 filters=Filters.private)

STATS_HANDLER = CommandHandler("botstats", stats, filters=Filters.user(OWNER_ID))
PASTE_HANDLER = DisableAbleCommandHandler("paste", paste, pass_args=True)
GET_PASTE_HANDLER = DisableAbleCommandHandler("getpaste",
                                              get_paste_content,
                                              pass_args=True)
PASTE_STATS_HANDLER = DisableAbleCommandHandler("pastestats",
                                                get_paste_stats,
                                                pass_args=True)
UD_HANDLER = DisableAbleCommandHandler("ud", ud)
WIKI_HANDLER = DisableAbleCommandHandler("wiki", wiki)
GIFID_HANDLER = DisableAbleCommandHandler("gifid", gifid)

dispatcher.add_handler(UD_HANDLER)
dispatcher.add_handler(PASTE_HANDLER)
dispatcher.add_handler(GET_PASTE_HANDLER)
dispatcher.add_handler(PASTE_STATS_HANDLER)
dispatcher.add_handler(ID_HANDLER)
dispatcher.add_handler(INFO_HANDLER)
dispatcher.add_handler(MD_HELP_HANDLER)
dispatcher.add_handler(STATS_HANDLER)
dispatcher.add_handler(GITHUB_HANDLER)
dispatcher.add_handler(REPO_HANDLER)
dispatcher.add_handler(
    DisableAbleCommandHandler("removebotkeyboard", reply_keyboard_remove))
dispatcher.add_handler(WIKI_HANDLER)
dispatcher.add_handler(GIFID_HANDLER)
