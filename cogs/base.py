"""
A base cog module with examples text, app (slash), and hybrid (both) commands.
"""
import discord


from cfg import cfg
from discord import app_commands
from discord.ext import commands


class BaseCog(commands.Cog):
  def __init__(self, bot: commands.Bot):
    self.bot = bot

  @commands.command()
  async def command(self, ctx: commands.Context):
    await ctx.reply("command")

  @app_commands.command()
  @app_commands.guilds(*cfg.guilds)
  async def app_command(self, itx: discord.Interaction):
    await itx.response.send_message("app_command")

  @commands.hybrid_command()
  @app_commands.guilds(*cfg.guilds)
  async def hybrid_command(self, ctx: commands.Context):
    await ctx.reply("hybrid_command")


async def setup(bot: commands.Bot):
  await bot.add_cog(BaseCog(bot))
