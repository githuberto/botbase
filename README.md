# Bot Base
A template project for creating [`discord.py`](https://github.com/Rapptz/discord.py) bots.

## Features
* An example `discord.py` bot with a cog and example commands.
* `sync.py` - a cog which adds hybrid commands (`!sync` and `/sync`) that sync your bot's application commands to Discord.
* `new.sh` - a script to create new bots based on this template.
* `check.sh` - a script and configuration to run [`pycodestyle`](https://pypi.org/project/pycodestyle/) and [`pyright`](https://pypi.org/project/pyright/) for [pep8](https://peps.python.org/pep-0008/) style checking and type checking.
* `logger.py` - a small module to easily log to the terminal and Discord chat in one call.
* `.gitignore` - a `.gitignore` which excludes the virtual environment, pycache, and `cfg.py` (where your Discord token lives).

## Usage

1. [Create a Discord bot.](https://discord.com/developers/docs/getting-started)
   
   **NOTE:** By default, this project requires you to enable the [message content intent](https://discordpy.readthedocs.io/en/stable/intents.html) in order to support text commands. If you only want to use app commands (aka, slash commands), you can remove `intents.message_content = True` from `main.py`.
3. Clone this repo and `discord.py` into the same directory.
```bash
git clone https://github.com/githuberto/botbase.git
git clone https://github.com/Rapptz/discord.py.git
```
3. Run `new.sh` from *parent* directory.
```bash
./botbase/new.sh your_bot_name
```
4. The directory `your_bot_name/` will be created. In this dir, create a `cfg.py` file for your tokens and data.
   This file should contain a global `cfg` variable bound to a `BotConfig()` instance.
   
   **🚨WARNING🚨:** *NEVER* include `cfg.py` in your version control for public repos, as this will leak your Discord token!
```py
from bot_config import BotConfig

cfg = BotConfig(
  discord_token="YOUR_DISCORD_TOKEN",
  guilds=[YOUR, GUILD, IDS])
```
5. Activate the virtual environment inside `your_bot_name/` and run the bot.
```bash
. venv/bin/activate
python3 main.py
```
6. Test your bot out. To get application commands to work, you'll first need to run `!sync` in your server.
